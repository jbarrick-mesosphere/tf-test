provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = "${var.name}"
  region  = "${var.region}"
  version = "${var.kubernetes_version}"

  node_pool {
    name       = "worker-pool"
    size       = "${var.worker_type}"
    node_count = "${var.number_workers}"
  }
}

output "kubeconfig" {
  value = "${digitalocean_kubernetes_cluster.cluster.kube_config.0.raw_config}"
}

variable "do_token" {}
variable "name" {}

variable "region" {
  default = "sfo2"
}

variable "kubernetes_version" {
  default = "1.14.2-do.0"
}

variable "worker_type" {
  default = "s-2vcpu-2gb"
}

variable "number_workers" {
  default = "3"
}
