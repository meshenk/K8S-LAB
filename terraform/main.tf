locals {
  server_name     = "${var.cluster_name}-server"
  worker_names    = [for i in range(1, var.worker_count + 1) : "${var.cluster_name}-worker-${i}"]
  kubeconfig_path = abspath("${path.module}/${var.kubeconfig_path}")
  scripts_dir     = replace(abspath("${path.module}/../scripts"), "\\", "/")
  generated_dir   = replace(abspath("${path.module}/generated"), "\\", "/")
}

resource "random_password" "cluster_token" {
  length  = 48
  special = false
}

resource "local_file" "server_cloudinit" {
  filename = "${path.module}/generated/${local.server_name}-cloud-init.yaml"
  content = templatefile("${path.module}/templates/server-cloud-init.yaml.tftpl", {
    hostname            = local.server_name
    token               = random_password.cluster_token.result
    rke2_version        = var.rke2_version
    use_china_mirror    = var.use_china_mirror
    control_plane_taint = var.control_plane_taint
  })
}

resource "terraform_data" "server" {
  input = {
    name        = local.server_name
    scripts_dir = local.scripts_dir
    specs       = "${var.image}-${var.server_cpus}-${var.server_memory}-${var.server_disk}"
    cloud_sha   = local_file.server_cloudinit.content_md5
  }

  provisioner "local-exec" {
    interpreter = ["PowerShell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-Command"]
    command     = "& '${local.scripts_dir}/launch-instance.ps1' -Name '${local.server_name}' -Image '${var.image}' -Cpus ${var.server_cpus} -Memory '${var.server_memory}' -Disk '${var.server_disk}' -CloudInit '${replace(abspath(local_file.server_cloudinit.filename), "\\", "/")}' -TimeoutSec ${var.multipass_command_timeout}"
  }

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["PowerShell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-Command"]
    command     = "& '${self.input.scripts_dir}/delete-instance.ps1' -Name '${self.input.name}'"
  }
}

data "external" "server_info" {
  program = [
    "PowerShell",
    "-NoProfile",
    "-ExecutionPolicy", "Bypass",
    "-File", "${local.scripts_dir}/get-instance.ps1"
  ]

  query = {
    name = local.server_name
  }

  depends_on = [terraform_data.server]
}

resource "local_file" "worker_cloudinit" {
  for_each = toset(local.worker_names)

  filename = "${path.module}/generated/${each.value}-cloud-init.yaml"
  content = templatefile("${path.module}/templates/agent-cloud-init.yaml.tftpl", {
    hostname         = each.value
    token            = random_password.cluster_token.result
    server_ip        = data.external.server_info.result.ip
    server_name      = local.server_name
    rke2_version     = var.rke2_version
    use_china_mirror = var.use_china_mirror
  })
}

resource "terraform_data" "workers" {
  input = {
    names       = join(",", local.worker_names)
    scripts_dir = local.scripts_dir
    specs       = "${var.image}-${var.worker_cpus}-${var.worker_memory}-${var.worker_disk}"
    cloud_sha   = sha256(join("", [for name in local.worker_names : local_file.worker_cloudinit[name].content]))
  }

  provisioner "local-exec" {
    interpreter = ["PowerShell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-Command"]
    command     = "& '${local.scripts_dir}/launch-workers.ps1' -Names '${join(",", local.worker_names)}' -Image '${var.image}' -Cpus ${var.worker_cpus} -Memory '${var.worker_memory}' -Disk '${var.worker_disk}' -GeneratedDir '${local.generated_dir}' -TimeoutSec ${var.multipass_command_timeout}"
  }

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["PowerShell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-Command"]
    command     = "& '${self.input.scripts_dir}/delete-instances.ps1' -Names '${self.input.names}'"
  }

  depends_on = [
    terraform_data.server,
    local_file.worker_cloudinit,
  ]
}

data "external" "worker_info" {
  for_each = toset(local.worker_names)

  program = [
    "PowerShell",
    "-NoProfile",
    "-ExecutionPolicy", "Bypass",
    "-File", "${local.scripts_dir}/get-instance.ps1"
  ]

  query = {
    name = each.value
  }

  depends_on = [terraform_data.workers]
}

resource "terraform_data" "kubeconfig" {
  depends_on = [terraform_data.server]

  input = {
    server_name = local.server_name
    server_ip   = data.external.server_info.result.ip
    out_file    = replace(local.kubeconfig_path, "\\", "/")
    scripts_dir = local.scripts_dir
  }

  provisioner "local-exec" {
    interpreter = ["PowerShell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-Command"]
    command     = "& '${local.scripts_dir}/fetch-kubeconfig.ps1' -ServerName '${local.server_name}' -ServerIP '${data.external.server_info.result.ip}' -OutFile '${replace(local.kubeconfig_path, "\\", "/")}'"
  }
}

resource "terraform_data" "wait_nodes" {
  depends_on = [
    terraform_data.kubeconfig,
    terraform_data.workers,
  ]

  input = {
    expected   = 1 + var.worker_count
    kubeconfig = replace(local.kubeconfig_path, "\\", "/")
    workers    = { for name, info in data.external.worker_info : name => info.result.ip }
  }

  provisioner "local-exec" {
    interpreter = ["PowerShell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-Command"]
    command     = "& '${local.scripts_dir}/wait-nodes.ps1' -Kubeconfig '${replace(local.kubeconfig_path, "\\", "/")}' -ExpectedNodes ${1 + var.worker_count} -TimeoutSec 900"
  }
}
