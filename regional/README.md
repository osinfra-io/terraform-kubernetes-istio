# Terraform Documentation

> A child module automatically inherits default (un-aliased) provider configurations from its parent. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.40.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.14.1 |
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
| [kubernetes_manifest.istio_gateway_mci](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_gateway_mcs](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace_v1.istio_ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
| [kubernetes_namespace_v1.istio_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifact_registry"></a> [artifact\_registry](#input\_artifact\_registry) | The registry to pull the images from | `string` | `"us-docker.pkg.dev/plt-lz-services-tf79-prod/platform-docker-virtual"` | no |
| <a name="input_cluster_prefix"></a> [cluster\_prefix](#input\_cluster\_prefix) | Prefix for your cluster name | `string` | n/a | yes |
| <a name="input_enable_istio_gateway"></a> [enable\_istio\_gateway](#input\_enable\_istio\_gateway) | Enable the Istio gateway, used for ingress traffic into the mesh | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment must be one of `sandbox`, `non-production`, `production` | `string` | `"sandbox"` | no |
| <a name="input_gateway_autoscale_min"></a> [gateway\_autoscale\_min](#input\_gateway\_autoscale\_min) | The minimum number of gateway replicas to run | `number` | `1` | no |
| <a name="input_istio_chart_repository"></a> [istio\_chart\_repository](#input\_istio\_chart\_repository) | The repository to pull the Istio Helm chart from | `string` | `"https://istio-release.storage.googleapis.com/charts"` | no |
| <a name="input_istio_gateway_cpu_limit"></a> [istio\_gateway\_cpu\_limit](#input\_istio\_gateway\_cpu\_limit) | The CPU limit for the Istio gateway | `string` | `"2000m"` | no |
| <a name="input_istio_gateway_cpu_request"></a> [istio\_gateway\_cpu\_request](#input\_istio\_gateway\_cpu\_request) | The CPU request for the Istio gateway | `string` | `"100m"` | no |
| <a name="input_istio_gateway_dns"></a> [istio\_gateway\_dns](#input\_istio\_gateway\_dns) | Map of attributes for the Istio gateway domain names, it is also used to create the managed certificate resource | <pre>map(object({<br>    managed_zone = string<br>    project      = string<br>  }))</pre> | `{}` | no |
| <a name="input_istio_gateway_mci_global_address"></a> [istio\_gateway\_mci\_global\_address](#input\_istio\_gateway\_mci\_global\_address) | The IP address for the Istio Gateway multi-cluster ingress | `string` | `""` | no |
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
| <a name="input_istio_version"></a> [istio\_version](#input\_istio\_version) | The version of istio to install | `string` | `"1.23.0"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of key/value pairs to assign to the resources being created | `map(string)` | `{}` | no |
| <a name="input_multi_cluster_service_clusters"></a> [multi\_cluster\_service\_clusters](#input\_multi\_cluster\_service\_clusters) | List of clusters to be included in the MultiClusterService | <pre>list(object({<br>    link = string<br>  }))</pre> | `[]` | no |
| <a name="input_node_location"></a> [node\_location](#input\_node\_location) | The zone in which the cluster's nodes should be located. If not specified, the cluster's nodes are located across zones in the region | `string` | `null` | no |
| <a name="input_project"></a> [project](#input\_project) | The ID of the project in which the resource belongs | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region in which the resource belongs | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_istio_gateway_ip"></a> [istio\_gateway\_ip](#output\_istio\_gateway\_ip) | The IP address of the Istio Gateway |
<!-- END_TF_DOCS -->
