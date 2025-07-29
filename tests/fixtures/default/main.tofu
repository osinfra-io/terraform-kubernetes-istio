# Required Providers
# https://opentofu.org/docs/language/providers/requirements

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    google-beta = {
      source = "hashicorp/google-beta"
    }
  }
}

module "test" {
  source = "../../../"

  gateway_dns = var.gateway_dns

  labels = {
    "mock-key" = "mock-value"
  }

  project = var.project
}
