resource "null_resource" "execute_cmd" {
  provisioner "local-exec" {
    command = "export VALUES_DIR=.;helm template --set license=${var.license} --set baseUrl=${var.baseurl} --set sizing.profile=${var.sizing} suse-observability-values  suse-observability/suse-observability-values --output-dir $VALUES_DIR"
  }
}


resource "kubernetes_namespace" "suse_observability" {
  metadata {
    name = "suse-observability"
  }
}
resource "helm_release" "suse_observability" {
  name      = "suse-observability"
  chart     = "suse-observability/suse-observability"
  namespace = kubernetes_namespace.suse_observability.metadata[0].name
 values = [
    file("./suse-observability-values/templates/baseConfig_values.yaml"),
    file("./suse-observability-values/templates/sizing_values.yaml")
  ]
}

