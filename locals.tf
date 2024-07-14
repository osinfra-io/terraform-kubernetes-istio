# Local Values
# https://www.terraform.io/docs/language/values/locals.html


locals {
  istio_gateway_domains = keys(var.istio_gateway_dns)
}
