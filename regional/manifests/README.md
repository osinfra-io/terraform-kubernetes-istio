# Terraform Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.31.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.gke_info_istio_virtual_services](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_cluster_services_destination_rule](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_gateway](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_kubernetes_default_destination_rule](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_peer_authentication](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_virtual_services](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_gke_info_istio_virtual_services"></a> [common\_gke\_info\_istio\_virtual\_services](#input\_common\_gke\_info\_istio\_virtual\_services) | The map of Istio VirtualServices to create for GKE Info, that are common among all regions | <pre>map(object({<br>    destination_host = string<br>    host             = string<br>  }))</pre> | n/a | yes |
| <a name="input_common_istio_virtual_services"></a> [common\_istio\_virtual\_services](#input\_common\_istio\_virtual\_services) | The map of Istio VirtualServices to create, that are common among all regions | <pre>map(object({<br>    destination_host = string<br>    destination_port = optional(number, 8080)<br>    host             = string<br>  }))</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment suffix for example: `sb` (Sandbox), `nonprod` (Non-Production), `prod` (Production) | `string` | `"sb"` | no |
| <a name="input_gke_info_istio_virtual_services"></a> [gke\_info\_istio\_virtual\_services](#input\_gke\_info\_istio\_virtual\_services) | The map of Istio VirtualServices to create for GKE Info | <pre>map(object({<br>    destination_host = string<br>    host             = string<br>  }))</pre> | n/a | yes |
| <a name="input_istio_failover_from_region"></a> [istio\_failover\_from\_region](#input\_istio\_failover\_from\_region) | The region to failover from | `string` | `""` | no |
| <a name="input_istio_failover_to_region"></a> [istio\_failover\_to\_region](#input\_istio\_failover\_to\_region) | The region to failover to | `string` | `""` | no |
| <a name="input_istio_virtual_services"></a> [istio\_virtual\_services](#input\_istio\_virtual\_services) | The map of Istio VirtualServices to create, that are unique to a region | <pre>map(object({<br>    destination_host = string<br>    destination_port = optional(number, 8080)<br>    host             = string<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
