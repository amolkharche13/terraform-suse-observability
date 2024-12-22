provider "helm" {
  kubernetes {
    config_path = "~/.kube/config" # Path to your kubeconfig file
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"  # Path to your kubeconfig file
}
terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12.1"
    }
  }
}
