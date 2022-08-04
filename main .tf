provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# Install the ECK operator
resource "helm_release" "elastic-system" {
  name       = "elastic-system"
  repository = "https://helm.elastic.co"
  chart      = "eck-operator"
  namespace  = "default"
}


resource "helm_release" "assignment" {
  name      = "assign-chart-latest"
  chart     = "./KandE"
  namespace = "default"
  depends_on = [
    helm_release.elastic-system
  ]
}


resource "helm_release" "fluent-bit" {
  name       = "fluent-bit"
  repository = "https://fluent.github.io/helm-charts"
  chart      = "fluent-bit"
  namespace  = "default"

  values = [
    "${file("./overideFluentbit.yaml")}"
  ]
}

