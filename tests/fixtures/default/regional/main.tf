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

# Helm Provider
# https://registry.terraform.io/providers/hashicorp/helm/latest

provider "helm" {
  kubernetes {

    cluster_ca_certificate = base64decode(
      data.google_container_cluster.this.master_auth[0].cluster_ca_certificate
    )

    host  = data.google_container_cluster.this.endpoint
    token = data.google_client_config.current.access_token
  }
}

# Kubernetes Provider
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest

provider "kubernetes" {
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.this.master_auth[0].cluster_ca_certificate
  )

  host  = data.google_container_cluster.this.endpoint
  token = data.google_client_config.current.access_token
}

# Google Client Config Data Source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config

data "google_client_config" "current" {
}

# Google Container Cluster Data Source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_cluster

data "google_container_cluster" "this" {
  name     = "mock-cluster"
  location = "mock-region"
  project  = var.project
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
