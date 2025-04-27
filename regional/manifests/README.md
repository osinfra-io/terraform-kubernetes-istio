# Terraform Documentation

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.36.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_helpers"></a> [helpers](#module\_helpers) | github.com/osinfra-io/terraform-core-helpers//child | v0.1.2 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.istio_authorization_policy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_cluster_services_destination_rule](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_gateway](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_gateway_authorization_policy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_kubernetes_default_destination_rule](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_peer_authentication](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_test_istio_virtual_services](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_virtual_services](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_istio_test_virtual_services"></a> [common\_istio\_test\_virtual\_services](#input\_common\_istio\_test\_virtual\_services) | The map of Istio VirtualServices to create for Istio testing, that are common among all regions | <pre>map(object({<br/>    destination_host = string<br/>    host             = string<br/>  }))</pre> | n/a | yes |
| <a name="input_common_virtual_services"></a> [common\_virtual\_services](#input\_common\_virtual\_services) | The map of Istio VirtualServices to create, that are common among all regions | <pre>map(object({<br/>    destination_host = string<br/>    destination_port = optional(number, 8080)<br/>    host             = string<br/>  }))</pre> | n/a | yes |
| <a name="input_failover_from_region"></a> [failover\_from\_region](#input\_failover\_from\_region) | The region to fail over from | `string` | `""` | no |
| <a name="input_failover_to_region"></a> [failover\_to\_region](#input\_failover\_to\_region) | The region to fail over to | `string` | `""` | no |
| <a name="input_istio_test_virtual_services"></a> [istio\_test\_virtual\_services](#input\_istio\_test\_virtual\_services) | The map of Istio VirtualServices to create for Istio testing | <pre>map(object({<br/>    destination_host = string<br/>    host             = string<br/>  }))</pre> | n/a | yes |
| <a name="input_virtual_services"></a> [virtual\_services](#input\_virtual\_services) | The map of Istio VirtualServices to create, that are unique to a region | <pre>map(object({<br/>    destination_host = string<br/>    destination_port = optional(number, 8080)<br/>    host             = string<br/>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
