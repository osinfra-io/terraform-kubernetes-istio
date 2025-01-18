# Kubernetes Manifest Resource
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest

resource "kubernetes_manifest" "istio_cluster_services_destination_rule" {
  manifest = {
    apiVersion = "networking.istio.io/v1beta1"
    kind       = "DestinationRule"

    metadata = {
      name      = "cluster-services"
      namespace = "istio-system"
    }

    spec = {
      host = "*.svc.cluster.local"

      trafficPolicy = {
        connectionPool = {

          # ConnectionPoolSettings
          # https://istio.io/latest/docs/reference/config/networking/destination-rule/#ConnectionPoolSettings-HTTPSettings

          http = {
            maxRequestsPerConnection = 0 # This is the default value
          }
        }

        loadBalancer = {
          simple = "LEAST_REQUEST"
          localityLbSetting = {
            enabled = true

            failover = [
              {
                from = var.failover_from_region
                to   = var.failover_to_region
              }
            ]
          }
        }

        # OutlierDetection
        # https://istio.io/latest/docs/reference/config/networking/destination-rule/#OutlierDetection

        outlierDetection = {

          # These are the default values

          consecutive5xxErrors = 5
          interval             = "10s"
          baseEjectionTime     = "30s"
          maxEjectionPercent   = 10
        }
      }
    }
  }
}

resource "kubernetes_manifest" "istio_kubernetes_default_destination_rule" {
  manifest = {
    apiVersion = "networking.istio.io/v1beta1"
    kind       = "DestinationRule"

    metadata = {
      name      = "kubernetes-default"
      namespace = "istio-system"
    }

    spec = {
      host = "kubernetes.default.svc"

      trafficPolicy = {
        tls = {
          mode = "DISABLE"
        }
      }
    }
  }
}

resource "kubernetes_manifest" "istio_gateway" {
  manifest = {
    apiVersion = "networking.istio.io/v1beta1"
    kind       = "Gateway"

    metadata = {
      name      = "global"
      namespace = "istio-ingress"
    }

    spec = {
      selector = {
        istio = "gateway"
      }

      servers = [
        {
          port = {
            name     = "https"
            number   = 443
            protocol = "HTTPS"
          }

          hosts = [
            "*"
          ]

          tls = {

            # As part of the incoming TLS connection, the gateway will decrypt the traffic in order to apply the routing rules.

            mode           = "SIMPLE"
            credentialName = "istio-gateway-tls"
          }
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "istio_gateway_authorization_policy" {
  manifest = {
    apiVersion = "security.istio.io/v1"
    kind       = "AuthorizationPolicy"

    metadata = {
      name      = "allow-all-gateway"
      namespace = "istio-ingress"
    }

    spec = {
      action = "ALLOW"
      rules = [
        {
          to = [
            {
              operation = {
                methods = ["*"]
              }
            }
          ]
        }
      ]

      selector = {
        matchLabels = {
          istio = "gateway"
        }
      }
    }
  }
}

resource "kubernetes_manifest" "istio_peer_authentication" {
  manifest = {
    apiVersion = "security.istio.io/v1beta1"
    kind       = "PeerAuthentication"

    metadata = {
      name      = "default"
      namespace = "istio-system"
    }

    spec = {
      mtls = {
        mode = "STRICT"
      }
    }
  }
}

resource "kubernetes_manifest" "istio_authorization_policy" {
  manifest = {
    apiVersion = "security.istio.io/v1"
    kind       = "AuthorizationPolicy"

    metadata = {
      name      = "deny-all"
      namespace = "istio-system"
    }

    # It's recommended to define authorization policies following the default-deny pattern to enhance your cluster’s security posture.
    # The spec field of the policy has the empty value {}. That value means that no traffic is permitted, effectively denying all requests.

    spec = {}
  }
}

resource "kubernetes_manifest" "istio_virtual_services" {
  for_each = merge(var.virtual_services, var.common_virtual_services)

  manifest = {
    apiVersion = "networking.istio.io/v1beta1"
    kind       = "VirtualService"

    metadata = {
      name      = each.key
      namespace = "istio-ingress"
    }

    spec = {
      gateways = [
        kubernetes_manifest.istio_gateway.manifest.metadata.name
      ]

      hosts = [
        each.value.host
      ]

      http = [
        {
          route = [
            {
              destination = {
                host = each.value.destination_host
                port = {
                  number = each.value.destination_port
                }
              }
            }
          ]
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "istio_test_istio_virtual_services" {
  for_each = merge(var.istio_test_virtual_services, var.istio_test_virtual_services)

  manifest = {
    apiVersion = "networking.istio.io/v1beta1"
    kind       = "VirtualService"
    metadata = {
      name      = each.key
      namespace = "istio-ingress"
    }

    spec = {
      gateways = [
        kubernetes_manifest.istio_gateway.manifest.metadata.name
      ]

      hosts = [
        each.value.host
      ]

      http = [
        {
          match = [
            {
              uri = {
                prefix = "/istio-test"
              }
            }
          ]

          route = [
            {
              destination = {
                host = each.value.destination_host
                port = {
                  number = 8080
                }
              }
            }
          ]
        }
      ]
    }
  }
}
