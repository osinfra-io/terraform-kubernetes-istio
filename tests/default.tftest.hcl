mock_provider "google" {}
mock_provider "helm" {}
mock_provider "kubernetes" {}

mock_provider "terraform" {
  mock_data "terraform_remote_state" {
    defaults = {
      outputs = {
        istio_gateway_mci_global_address = "35.184.145.227"
      }
    }
  }
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
}
