provider "helm" {
  kubernetes {
    config_path = local_file.kubeconfig.filename
  }
}
terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12.1"
    }
  }
}
