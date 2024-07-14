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

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "github.com/osinfra-io/terraform-google-kubernetes//global?ref=v0.0.0"

  source = "../../../"


  istio_gateway_dns = {
    "gateway.test.gcp.osinfra.io" = {
      managed_zone = "test-gcp-osinfra-io"
      project      = var.dns_project_id
    }

    "stream-team.test.gcp.osinfra.io" = {
      managed_zone = "test-gcp-osinfra-io"
      project      = var.dns_project_id
    }
  }

  project = var.project
}
