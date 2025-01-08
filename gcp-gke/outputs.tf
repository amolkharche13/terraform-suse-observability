output "kubeconfig" {
  value = templatefile("${path.module}/kubeconfig.tmpl", {
    cluster_name = google_container_cluster.gke_cluster.name
    endpoint     = google_container_cluster.gke_cluster.endpoint
    ca_cert      = base64decode(google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate)
  })
  sensitive = true
}
