# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  env = lookup(local.env_map, var.environment, "none")

  env_map = {
    "non-production" = "nonprod"
    "production"     = "prod"
    "sandbox"        = "sb"

  }

  istio_gateway_datadog_apm_env = <<EOF
    {
    \"DD_ENV\":\"${var.environment}\"\,
    \"DD_SERVICE\":\"istio-gateway\"\,
    \"DD_VERSION\":\"${var.istio_version}\"
    }
  EOF

  istio_gateway_proxy_config = <<EOF
    {\"tracing\":{\"datadog\":{\"address\":\"$(HOST_IP):8126\"}}\,\"proxyMetadata\":{\"DD_ENV\":\"${var.environment}\"\,\"DD_SERVICE\":\"istio-gateway\"\,\"DD_VERSION\":\"${var.istio_version}\"\,\"ISTIO_META_DNS_AUTO_ALLOCATE\":\"true\"\,\"ISTIO_META_DNS_CAPTURE\":\"true\"\,\"meshId\":\"default\"}
  EOF

  gateway_domains    = keys(var.gateway_dns)
  multi_cluster_name = "${var.cluster_prefix}-${var.region}-${local.env}"
}
