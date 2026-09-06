variable "cluster_name" {
  description = "Name prefix for Multipass instances."
  type        = string
  default     = "rke2"
}

variable "image" {
  description = "Ubuntu image alias used by Multipass."
  type        = string
  default     = "22.04"
}

variable "worker_count" {
  description = "Number of RKE2 agent (worker) nodes."
  type        = number
  default     = 2

  validation {
    condition     = var.worker_count >= 1 && var.worker_count <= 5
    error_message = "worker_count must be between 1 and 5 for this lab."
  }
}

variable "server_cpus" {
  type    = number
  default = 2
}

variable "server_memory" {
  type    = string
  default = "4G"
}

variable "server_disk" {
  type    = string
  default = "40G"
}

variable "worker_cpus" {
  type    = number
  default = 2
}

variable "worker_memory" {
  type    = string
  default = "4G"
}

variable "worker_disk" {
  type    = string
  default = "30G"
}

variable "rke2_version" {
  description = "RKE2 version such as v1.31.7+rke2r1. Empty uses the stable channel."
  type        = string
  default     = ""
}

variable "use_china_mirror" {
  description = "Download RKE2 binaries from rancher.cn and pull container images via China Docker Hub proxies. Do not use Aliyun system-default-registry; it often lags current RKE2 tags."
  type        = bool
  default     = true
}

variable "control_plane_taint" {
  description = "Keep workloads off the server node (true 一主两从)."
  type        = bool
  default     = true
}

variable "multipass_path" {
  description = "Path to the multipass executable. Leave as multipass if it is on PATH."
  type        = string
  default     = "multipass"
}

variable "multipass_command_timeout" {
  description = "Timeout in seconds for Multipass CLI calls (image download + RKE2 bootstrap)."
  type        = number
  default     = 2700
}

variable "kubeconfig_path" {
  description = "Where to write the rewritten kubeconfig on the Windows host."
  type        = string
  default     = "../kubeconfig.yaml"
}
