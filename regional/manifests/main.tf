# Kubernetes Manifest Resource
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest

resource "kubernetes_manifest" "istio_cluster_services_destination_rule" {
  manifest = {
    "apiVersion" = "networking.istio.io/v1beta1"
    "kind"       = "DestinationRule"

    "metadata" = {
      "name"      = "cluster-services"
      "namespace" = "istio-system"
    }

    "spec" = {
      "host" = "*.svc.cluster.local"

      "trafficPolicy" = {
        "connectionPool" = {

          # ConnectionPoolSettings
          # https://istio.io/latest/docs/reference/config/networking/destination-rule/#ConnectionPoolSettings-HTTPSettings

          "http" = {
            "maxRequestsPerConnection" = 0 # This is the default value
          }
        }

        "loadBalancer" = {
          "simple" = "LEAST_REQUEST"
          "localityLbSetting" = {
            "enabled" = true

            "failover" = [
              {
                "from" = var.istio_failover_from_region
                "to"   = var.istio_failover_to_region
              }
            ]
          }
        }

        # OutlierDetection
        # https://istio.io/latest/docs/reference/config/networking/destination-rule/#OutlierDetection

        "outlierDetection" = {

          # These are the default values

          "consecutive5xxErrors" = 5
          "interval"             = "10s"
          "baseEjectionTime"     = "30s"
          "maxEjectionPercent"   = 10
        }
      }
    }
  }
}

resource "kubernetes_manifest" "istio_kubernetes_default_destination_rule" {
  manifest = {
    "apiVersion" = "networking.istio.io/v1beta1"
    "kind"       = "DestinationRule"

    "metadata" = {
      "name"      = "kubernetes-default"
      "namespace" = "istio-system"
    }

    "spec" = {
      "host" = "kubernetes.default.svc"

      "trafficPolicy" = {
        "tls" = {
          "mode" = "DISABLE"
        }
      }
    }
  }
}

resource "kubernetes_manifest" "istio_gateway" {
  manifest = {
    "apiVersion" = "networking.istio.io/v1beta1"
    "kind"       = "Gateway"

    "metadata" = {
      "name"      = "global"
      "namespace" = "istio-ingress"
    }

    "spec" = {
      "selector" = {
        "istio" = "gateway"
      }

      "servers" = [
        {
          "port" = {
            "name"     = "https"
            "number"   = 443
            "protocol" = "HTTPS"
          }

          "hosts" = [
            "*"
          ]

          "tls" = {

            # As part of the incoming TLS connection, the gateway will decrypt the traffic in order to apply the routing rules.
            # This is an additional manual step to configure the gateway to use the TLS certificate. This is not recommended for production use.
            # openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=Open Source Infrastructure as Code/CN=osinfra.io' -keyout osinfra.io.key -out osinfra.io.crt
            # openssl req -out gateway.istio-ingress.svc.cluster.local.csr -newkey rsa:2048 -nodes -keyout gateway.istio-ingress.svc.cluster.local.key -subj "/O=Open Source Infrastructure as Code/CN=osinfra.io"
            # openssl x509 -req -sha256 -days 365 -CA osinfra.io.crt -CAkey osinfra.io.key -set_serial 0 -in gateway.istio-ingress.svc.cluster.local.csr -out gateway.istio-ingress.svc.cluster.local.crt
            # kubectl create -n istio-ingress secret tls gateway-tls --key=gateway.istio-ingress.svc.cluster.local.key --cert=gateway.istio-ingress.svc.cluster.local.crt

            "mode"           = "SIMPLE"
            "credentialName" = "gateway-tls"
          }
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "istio_peer_authentication" {
  manifest = {
    "apiVersion" = "security.istio.io/v1beta1"
    "kind"       = "PeerAuthentication"

    "metadata" = {
      "name"      = "default"
      "namespace" = "istio-system"
    }

    "spec" = {
      "mtls" = {
        "mode" = "STRICT"
      }
    }
  }
}

resource "kubernetes_manifest" "istio_virtual_services" {
  for_each = merge(var.istio_virtual_services, var.common_istio_virtual_services)

  manifest = {
    "apiVersion" = "networking.istio.io/v1beta1"
    "kind"       = "VirtualService"

    "metadata" = {
      "name"      = each.key
      "namespace" = "istio-ingress"
    }

    "spec" = {
      "gateways" = [
        kubernetes_manifest.istio_gateway.manifest.metadata.name
      ]
      "hosts" = [
        each.value.host
      ]

      "http" = [
        {
          "route" = [
            {
              "destination" = {
                "host" = each.value.destination_host
                "port" = {
                  "number" = each.value.destination_port
                }
              }
            }
          ]
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "gke_info_istio_virtual_services" {
  for_each = merge(var.gke_info_istio_virtual_services, var.common_gke_info_istio_virtual_services)

  manifest = {
    "apiVersion" = "networking.istio.io/v1beta1"
    "kind"       = "VirtualService"
    "metadata" = {
      "name"      = each.key
      "namespace" = "istio-ingress"
    }
    "spec" = {
      "gateways" = [
        kubernetes_manifest.istio_gateway.manifest.metadata.name
      ]
      "hosts" = [
        each.value.host
      ]
      "http" = [
        {
          "match" = [
            {
              "uri" = {
                "prefix" = "/gke-info-go"
              }
            }
          ]
          "route" = [
            {
              "destination" = {
                "host" = each.value.destination_host
                "port" = {
                  "number" = 8080
                }
              }
            }
          ]
        }
      ]
    }
  }
}
