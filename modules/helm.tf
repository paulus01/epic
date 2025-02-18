provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}

resource "helm_release" "nginx-deployment" {
  name    = "nginx-deployment"
  chart   = "./nginx-deployment"
  version = "0.0.1"
  values = [yamlencode({
  })]
  force_update = true
}
