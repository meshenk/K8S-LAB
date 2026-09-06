output "cluster_architecture" {
  value = "1 RKE2 server (${local.server_name}) + ${var.worker_count} RKE2 agents"
}

output "server_name" {
  value = local.server_name
}

output "server_ip" {
  value = data.external.server_info.result.ip
}

output "workers" {
  value = {
    for name, info in data.external.worker_info :
    name => info.result.ip
  }
}

output "kubeconfig_path" {
  value = local.kubeconfig_path
}

output "kubectl_get_nodes" {
  value = "kubectl --kubeconfig ${local.kubeconfig_path} get nodes -o wide"
}

output "cluster_token" {
  value     = random_password.cluster_token.result
  sensitive = true
}
