# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  istio_gateway_datadog_apm_env = <<EOF
    {
    \"DD_ENV\":\"${var.environment}\"\,
    \"DD_SERVICE\":\"istio-gateway\"\,
    \"DD_VERSION\":\"${var.istio_version}\"
    }
  EOF

  istio_gateway_domains = keys(var.istio_gateway_dns)
  name                  = var.node_location == null ? var.region : "${var.region}-${var.node_location}"
  multi_cluster_name    = "${var.cluster_prefix}-${var.region}-${var.environment}"
}
