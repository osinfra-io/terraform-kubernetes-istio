mock_provider "google" {}
mock_provider "helm" {}
mock_provider "kubernetes" {}

mock_provider "terraform" {
  mock_data "terraform_remote_state" {
    defaults = {
      outputs = {
        istio_gateway_mci_global_address = "192.0.2.0" # https://www.rfc-editor.org/rfc/rfc5737#section-3
      }
    }
  }
}

variables {
  environment = "mock-enviroment"

  istio_gateway_dns = {
    "mock-environment.mock-subdomain.mock-domain" = {
      managed_zone = "mock-environment-mock-subdomain-mock-domain"
      project      = "mock-dns-project"
    }
  }

  project = "mock-project"
  region  = "mock-region"
}

run "primary" {
  command = apply

  module {
    source = "./tests/fixtures/primary"
  }
}

run "primary_regional" {
  command = apply

  module {
    source = "./tests/fixtures/primary/regional"
  }
  variables {
    istio_remote_injection_path = "inject/cluster/mock-cluster/net/mock-network"
    istio_remote_injection_url  = "https://istiod.istio-system.clusterset.local:15017"
  }
}

run "remote" {
  command = apply

  module {
    source = "./tests/fixtures/remote"
  }
}

run "remote_regional" {
  command = apply

  module {
    source = "./tests/fixtures/remote/regional"
  }

  variables {
    istio_external_istiod = true
  }
}
