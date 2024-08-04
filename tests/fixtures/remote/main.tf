# Required Providers
# https://developer.hashicorp.com/terraform/language/providers/requirements

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

module "test" {
  source = "../../../"

  istio_gateway_dns = var.istio_gateway_dns
  labels            = local.labels
  project           = var.project
}
