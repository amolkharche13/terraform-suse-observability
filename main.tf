resource "null_resource" "execute_cmd" {
  provisioner "local-exec" {
    command = "export VALUES_DIR=.;helm template --set license=${var.license} --set baseUrl=${var.baseurl} --set sizing.profile=${var.sizing} suse-observability-values  suse-observability/suse-observability-values --output-dir $VALUES_DIR"
  }
}

data "local_file" "base_config" {
  filename   = "${path.root}/suse-observability-values/templates/baseConfig_values.yaml"
  depends_on = [null_resource.execute_cmd]
}

data "local_file" "sizing_config" {
  filename   = "${path.root}/suse-observability-values/templates/sizing_values.yaml"
  depends_on = [null_resource.execute_cmd]
}

resource "helm_release" "suse_observability" {
  name      = "suse-observability"
  chart     = "suse-observability/suse-observability"
  namespace = "suse-observability"
  create_namespace = true
  values = concat(
[
    data.local_file.base_config.content,
    data.local_file.sizing_config.content

  ],
    var.extra_values_file != null ? [file(var.extra_values_file)] : []
)
  depends_on = [null_resource.execute_cmd]
}
