# Tracks Helm template manifests in state to detect changes during terraform plan
resource "null_resource" "this" {
  triggers = data.helm_template.this.manifests
}
