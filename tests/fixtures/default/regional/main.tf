# Required Providers
# https://developer.hashicorp.com/terraform/language/providers/requirements

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

module "test" {
  source = "../../../../regional"

  artifact_registry           = "mock-docker.pkg.dev/mock-project/mock-virtual"
  cluster_prefix              = "mock"
  enable_istio_gateway        = true
  gateway_dns                 = var.gateway_dns
  helpers_cost_center         = var.helpers_cost_center
  helpers_data_classification = var.helpers_data_classification
  helpers_email               = var.helpers_email
  helpers_repository          = var.helpers_repository
  helpers_team                = var.helpers_team

  labels = {
    mock-key = "mock-value"
  }

  multi_cluster_service_clusters = [
    {
      "link" = "mock-region/mock-cluster"
    }
  ]

  project = var.project
}
