# <img align="left" width="45" height="45" src="https://github.com/user-attachments/assets/ce1fe535-f4f3-451f-bbd9-45fde04c000c"> Kubernetes - Istio Terraform Module

**[GitHub Actions](https://github.com/osinfra-io/terraform-kubernetes-istio/actions):**

[![Terraform Tests](https://github.com/osinfra-io/terraform-kubernetes-istio/actions/workflows/test.yml/badge.svg)](https://github.com/osinfra-io/terraform-kubernetes-istio/actions/workflows/test.yml) [![Dependabot](https://github.com/osinfra-io/terraform-kubernetes-istio/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/terraform-kubernetes-istio/actions/workflows/dependabot.yml)

**[Infracost](https://www.infracost.io):**

[![infracost](https://img.shields.io/endpoint?url=https://dashboard.api.infracost.io/shields/json/cbeecfe3-576f-4553-984c-e451a575ee47/repos/925e2406-d209-4aca-847d-21257bc478a5/branch/72fc4157-6bf8-46c0-9d51-593f3cd5bdef)](https://dashboard.infracost.io/org/osinfra-io/repos/925e2406-d209-4aca-847d-21257bc478a5?tab=settings)

💵 Monthly estimates based on Infracost baseline costs.

## Repository Description

Terraform **example** module for a Google Cloud Platform Kubernetes engine cluster.

> [!NOTE]
> We do not recommend consuming this module like you might a [public module](https://registry.terraform.io/browse/modules). It is a baseline, something you can fork, potentially maintain, and modify to fit your organization's needs. Using public modules vs. writing your own has various [drivers and trade-offs](https://docs.osinfra.io/fundamentals/architecture-decision-records/adr-0003) that your organization should evaluate.

## 🔩 Usage

> [!TIP]
> You can check the [tests/fixtures](tests/fixtures) directory for example configurations. These fixtures set up the system for testing by providing all the necessary initial code, thus creating good examples on which to base your configurations.

## <img align="left" width="35" height="35" src="https://github.com/osinfra-io/github-organization-management/assets/1610100/39d6ae3b-ccc2-42db-92f1-276a5bc54e65"> Development

Our focus is on the core fundamental practice of platform engineering, Infrastructure as Code.

>Open Source Infrastructure (as Code) is a development model for infrastructure that focuses on open collaboration and applying relative lessons learned from software development practices that organizations can use internally at scale. - [Open Source Infrastructure (as Code)](https://www.osinfra.io)

To avoid slowing down stream-aligned teams, we want to open up the possibility for contributions. The Open Source Infrastructure (as Code) model allows team members external to the platform team to contribute with only a slight increase in cognitive load. This section is for developers who want to contribute to this repository, describing the tools used, the skills, and the knowledge required, along with Terraform documentation.

See the documentation for setting up a local development environment [here](https://docs.osinfra.io/fundamentals/development-setup).

### 🛠️ Tools

- [checkov](https://github.com/bridgecrewio/checkov)
- [helm](https://github.com/helm/helm)
- [infracost](https://github.com/infracost/infracost)
- [pre-commit](https://github.com/pre-commit/pre-commit)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)

### 📋 Skills and Knowledge

Links to documentation and other resources required to develop and iterate in this repository successfully.

- [istio](https://istio.io/latest/docs)
  - [istio on gke](https://istio.io/latest/docs/setup/platform-setup/gke)

### 🔍 Tests

You'll need to be a member of the [platform-contributors](https://groups.google.com/a/osinfra.io/g/platform-contributors) Google Group to run the tests. This group manages access to Testing/Sandbox folder in the resource hierarchy. You can request access to this group by opening an issue [here](https://github.com/osinfra-io/google-cloud-hierarchy/issues/new?assignees=&labels=enhancement&projects=&template=add-update-identity-group.yml&title=Add+or+update+identity+group).

```none
terraform init
```

```none
terraform test
```

## 📓 Terraform Documentation

> A child module automatically inherits default (un-aliased) provider configurations from its parent. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

No requirements.

### Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.40.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [google_compute_global_address.istio_gateway_mci](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_managed_ssl_certificate.istio_gateway_mci](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_managed_ssl_certificate) | resource |
| [google_compute_ssl_policy.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_ssl_policy) | resource |
| [google_dns_record_set.istio_gateway_mci](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gke_fleet_host_project_id"></a> [gke\_fleet\_host\_project\_id](#input\_gke\_fleet\_host\_project\_id) | The project ID of the GKE Hub host project | `string` | `""` | no |
| <a name="input_istio_gateway_dns"></a> [istio\_gateway\_dns](#input\_istio\_gateway\_dns) | Map of attributes for the Istio gateway domain names, it is also used to create the managed certificate resource | <pre>map(object({<br>    managed_zone = string<br>    project      = string<br>  }))</pre> | `{}` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of key/value pairs to assign to the resources being created | `map(string)` | `{}` | no |
| <a name="input_project"></a> [project](#input\_project) | The ID of the project in which the resource belongs | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_istio_gateway_mci_global_address"></a> [istio\_gateway\_mci\_global\_address](#output\_istio\_gateway\_mci\_global\_address) | The IP address for the Istio Gateway multi-cluster ingress |
| <a name="output_istio_gateway_mci_ssl_certificate_name"></a> [istio\_gateway\_mci\_ssl\_certificate\_name](#output\_istio\_gateway\_mci\_ssl\_certificate\_name) | The name of the SSL certificate for the Istio Gateway multi-cluster ingress |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## 📓 Terraform Regional Documentation

- [regional](regional/README.md)
- [regional/manifests](regional/manifests/README.md)
