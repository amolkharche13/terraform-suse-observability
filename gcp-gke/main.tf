resource "google_container_cluster" "gke_cluster" {
  name     = "observability-gke-cluster"
  location = var.region
  initial_node_count = 2

  node_config {
    machine_type = "e2-medium"
  }
}
resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"
  }
}
