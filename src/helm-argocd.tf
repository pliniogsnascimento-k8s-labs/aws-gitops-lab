resource "helm_release" "argocd" {
  count   = var.enable_argocd ? 1 : 0
  name    = "argo-cd"
  version = "5.46.0"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  values = ["${file("${path.module}/templates/argocd.yaml")}"]
}

resource "helm_release" "argo-apps" {
  name             = "argo-apps"
  chart            = "./charts/argocd-apps"
  namespace        = "argocd"
  create_namespace = true

  depends_on = [
    helm_release.argocd
  ]
}
