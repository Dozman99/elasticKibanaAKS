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

}
