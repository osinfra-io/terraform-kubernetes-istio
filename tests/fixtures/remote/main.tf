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

  gke_fleet_host_project_id = var.gke_fleet_host_project_id
  labels                    = local.labels
  project                   = var.project
}
