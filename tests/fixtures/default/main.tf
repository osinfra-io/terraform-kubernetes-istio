# Required Providers
# https://developer.hashicorp.com/terraform/language/providers/requirements

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

  gateway_dns                 = var.gateway_dns
  helpers_cost_center         = var.helpers_cost_center
  helpers_data_classification = var.helpers_data_classification
  helpers_email               = var.helpers_email
  helpers_repository          = var.helpers_repository
  helpers_team                = var.helpers_team

  labels = {
    mock-key = "mock-value"
  }

  project = var.project
}
