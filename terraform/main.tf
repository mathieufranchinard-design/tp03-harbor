terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "/etc/rancher/k3s/k3s.yaml"
  }
}

resource "helm_release" "harbor" {
  name             = "harbor"
  repository       = "https://helm.goharbor.io"
  chart            = "harbor"
  namespace        = "harbor"
  create_namespace = true

  set {
    name  = "expose.type"
    value = "nodePort"
  }

  set {
    name  = "expose.tls.enabled"
    value = "false"
  }

  set {
    name  = "externalURL"
    value = "http://localhost:30002"
  }

  set {
    name  = "expose.nodePort.ports.http.nodePort"
    value = "30002"
  }
}
