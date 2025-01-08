resource "google_container_cluster" "gke_cluster" {
  name     = var.cluster_name
  location = var.region
  initial_node_count = 2
}
resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.node_pool
  location   = var.region
  cluster    = google_container_cluster.gke_cluster.name
  node_count = 2

  node_config {
    preemptible  = true
    machine_type = var.machine_type
  }
}
  management {
    auto_repair  = true
    auto_upgrade = true
  }
autoscaling {
    min_node_count = 2
    max_node_count = 3
  }
}
