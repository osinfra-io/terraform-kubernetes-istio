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
  workspace = "kitchen-terraform-gke-fleet-member-regional-gcp"

  config = {
    bucket = "plt-lz-testing-2c8b-sb"
  }
}

module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "git@github.com:osinfra-io/terraform-google-kubernetes-engine//regional/istio?ref=v0.0.0"

  source                     = "../../../../regional"
  artifact_registry          = "us-docker.pkg.dev/test-default-tf75-sb/test-virtual"
  cluster_prefix             = "fleet-member"
  istio_remote_injection_url = "https://istiod.istio-system.svc.clusterset.local:15017/inject/cluster/fleet-host-us-east1-b/net/standard-shared"


  project = var.project
  region  = var.region
}