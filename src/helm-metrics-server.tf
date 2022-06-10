resource "helm_release" "metrics-server" {
  name = "metrics-server"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metrics-server"
  namespace  = "kube-system"

  values = ["${file("${path.module}/templates/metrics-server.yaml")}"]
}
