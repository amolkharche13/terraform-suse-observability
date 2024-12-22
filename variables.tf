variable "license" {
  description = " License from SSC portal"
  type        = string
}

variable "baseurl" {
  description = "The external URL for SUSE Observability"
  type        = string
  default     = "http://localhost:8080"
}

variable "sizing" {
  description = "Sizing profile "
  type        = string
  default     = "10-nonha"
}
variable "extra_values_file" {
  description = "Optional extra values file to pass to the Helm release"
  type        = string
  default     = null
}

