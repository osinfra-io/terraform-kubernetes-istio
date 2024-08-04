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
      local.regional.cluster_ca_certificate
    )

    host  = local.regional.cluster_endpoint
    token = data.google_client_config.current.access_token
  }
}

# Kubernetes Provider
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest

provider "kubernetes" {
  cluster_ca_certificate = base64decode(
    local.regional.cluster_ca_certificate
  )

  host  = "https://${local.regional.cluster_endpoint}"
  token = data.google_client_config.current.access_token
}

# Google Client Config Data Source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config

data "google_client_config" "current" {
}

# Remote State Data Source
# https://www.terraform.io/language/state/remote-state-data

# This is the preferred way to get the remote state data from other terraform workspaces and how we recommend
# you do it in your root module.

data "terraform_remote_state" "regional" {
  backend   = "gcs"
  workspace = "mock-workspace"

  config = {
    bucket = "mock-bucket"
  }
}

module "test" {
  source = "../../../../regional"

  artifact_registry            = "mock-docker.pkg.dev/mock-project/mock-virtual"
  cluster_prefix               = "mock"
  enable_istio_gateway         = true
  istio_external_istiod        = var.istio_external_istiod
  istio_control_plane_clusters = var.istio_control_plane_clusters
  istio_gateway_dns            = var.istio_gateway_dns
  istio_remote_injection_path  = var.istio_remote_injection_path
  istio_remote_injection_url   = var.istio_remote_injection_url
  labels                       = local.labels
  project                      = var.project
  region                       = var.region
}
