# Terraform Documentation

> A child module automatically inherits default (un-aliased) provider configurations from its parent. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.37.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.14.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.31.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_global_address.istio_gateway](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_dns_record_set.istio_gateway](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [helm_release.base](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.gateway](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.istiod](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_ingress_v1.istio_gateway](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_manifest.istio_gateway_backendconfig](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_gateway_frontendconfig](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_gateway_managed_certificate](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_service_exports](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifact_registry"></a> [artifact\_registry](#input\_artifact\_registry) | The registry to pull the images from | `string` | `"us-docker.pkg.dev/plt-lz-services-tf79-prod/platform-docker-virtual"` | no |
| <a name="input_cluster_prefix"></a> [cluster\_prefix](#input\_cluster\_prefix) | Prefix for your cluster name | `string` | n/a | yes |
| <a name="input_enable_istio_gateway"></a> [enable\_istio\_gateway](#input\_enable\_istio\_gateway) | Enable the Istio gateway, used for ingress traffic into the mesh | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment suffix for example: `sb` (Sandbox), `nonprod` (Non-Production), `prod` (Production) | `string` | `"sb"` | no |
| <a name="input_gateway_autoscale_min"></a> [gateway\_autoscale\_min](#input\_gateway\_autoscale\_min) | The minimum number of gateway replicas to run | `number` | `1` | no |
| <a name="input_istio_chart_repository"></a> [istio\_chart\_repository](#input\_istio\_chart\_repository) | The repository to pull the Istio Helm chart from | `string` | `"https://istio-release.storage.googleapis.com/charts"` | no |
| <a name="input_istio_config_cluster"></a> [istio\_config\_cluster](#input\_istio\_config\_cluster) | Boolean to configure a remote cluster as the config cluster for an external istiod | `bool` | `false` | no |
| <a name="input_istio_external_istiod"></a> [istio\_external\_istiod](#input\_istio\_external\_istiod) | Boolean to configure a remote cluster data plane controlled by an external istiod | `bool` | `false` | no |
| <a name="input_istio_gateway_cpu_limit"></a> [istio\_gateway\_cpu\_limit](#input\_istio\_gateway\_cpu\_limit) | The CPU limit for the Istio gateway | `string` | `"2000m"` | no |
| <a name="input_istio_gateway_cpu_request"></a> [istio\_gateway\_cpu\_request](#input\_istio\_gateway\_cpu\_request) | The CPU request for the Istio gateway | `string` | `"100m"` | no |
| <a name="input_istio_gateway_dns"></a> [istio\_gateway\_dns](#input\_istio\_gateway\_dns) | Map of attributes for the Istio gateway domain names, it is also used to create the managed certificate resource | <pre>map(object({<br>    managed_zone = string<br>    project      = string<br>  }))</pre> | `{}` | no |
| <a name="input_istio_gateway_memory_limit"></a> [istio\_gateway\_memory\_limit](#input\_istio\_gateway\_memory\_limit) | The memory limit for the Istio gateway | `string` | `"1024Mi"` | no |
| <a name="input_istio_gateway_memory_request"></a> [istio\_gateway\_memory\_request](#input\_istio\_gateway\_memory\_request) | The memory request for the Istio gateway | `string` | `"128Mi"` | no |
| <a name="input_istio_pilot_autoscale_min"></a> [istio\_pilot\_autoscale\_min](#input\_istio\_pilot\_autoscale\_min) | The minimum number of Istio pilot replicas to run | `number` | `1` | no |
| <a name="input_istio_pilot_cpu_limit"></a> [istio\_pilot\_cpu\_limit](#input\_istio\_pilot\_cpu\_limit) | The CPU limit for the Istio pilot | `string` | `"1000m"` | no |
| <a name="input_istio_pilot_cpu_request"></a> [istio\_pilot\_cpu\_request](#input\_istio\_pilot\_cpu\_request) | The CPU request for the Istio pilot | `string` | `"500m"` | no |
| <a name="input_istio_pilot_memory_limit"></a> [istio\_pilot\_memory\_limit](#input\_istio\_pilot\_memory\_limit) | The memory limit for the Istio pilot | `string` | `"4096Mi"` | no |
| <a name="input_istio_pilot_memory_request"></a> [istio\_pilot\_memory\_request](#input\_istio\_pilot\_memory\_request) | The memory request for the Istio pilot | `string` | `"2048Mi"` | no |
| <a name="input_istio_pilot_replica_count"></a> [istio\_pilot\_replica\_count](#input\_istio\_pilot\_replica\_count) | The number of Istio pilot replicas to run | `number` | `1` | no |
| <a name="input_istio_proxy_cpu_limit"></a> [istio\_proxy\_cpu\_limit](#input\_istio\_proxy\_cpu\_limit) | The CPU limit for the Istio proxy | `string` | `"2000m"` | no |
| <a name="input_istio_proxy_cpu_request"></a> [istio\_proxy\_cpu\_request](#input\_istio\_proxy\_cpu\_request) | The CPU request for the Istio proxy | `string` | `"100m"` | no |
| <a name="input_istio_proxy_memory_limit"></a> [istio\_proxy\_memory\_limit](#input\_istio\_proxy\_memory\_limit) | The memory limit for the Istio proxy | `string` | `"1024Mi"` | no |
| <a name="input_istio_proxy_memory_request"></a> [istio\_proxy\_memory\_request](#input\_istio\_proxy\_memory\_request) | The memory request for the Istio proxy | `string` | `"128Mi"` | no |
| <a name="input_istio_remote_injection_path"></a> [istio\_remote\_injection\_path](#input\_istio\_remote\_injection\_path) | The sidecar injector mutating webhook configuration path value for the clientConfig.service field | `string` | `"/inject"` | no |
| <a name="input_istio_remote_injection_url"></a> [istio\_remote\_injection\_url](#input\_istio\_remote\_injection\_url) | The sidecar injector mutating webhook configuration clientConfig.url value | `string` | `""` | no |
| <a name="input_istio_version"></a> [istio\_version](#input\_istio\_version) | The version of istio to install | `string` | `"1.22.2"` | no |
| <a name="input_node_location"></a> [node\_location](#input\_node\_location) | The zone in which the cluster's nodes should be located. If not specified, the cluster's nodes are located across zones in the region | `string` | `null` | no |
| <a name="input_project"></a> [project](#input\_project) | The ID of the project in which the resource belongs | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to deploy the resources into | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_istio_gateway_ip"></a> [istio\_gateway\_ip](#output\_istio\_gateway\_ip) | The IP address of the Istio Gateway |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->