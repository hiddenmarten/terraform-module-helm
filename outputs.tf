output "namespace" {
  description = "Namespace where helm chart is deployed"
  value       = var.namespace
}

output "name" {
  description = "Name of the helm release"
  value       = helm_release.this.name
}

output "chart" {
  description = "The chart name that was released"
  value       = helm_release.this.chart
}

output "version" {
  description = "The chart version that was released"
  value       = helm_release.this.version
}

output "status" {
  description = "Status of the release"
  value       = helm_release.this.status
}

output "metadata" {
  description = "Metadata block with release information"
  value       = helm_release.this.metadata
}

output "manifest" {
  description = "The rendered manifest of the release as JSON"
  value       = helm_release.this.manifest
}

output "values" {
  description = "The values used for the release"
  value       = helm_release.this.values
}

output "id" {
  description = "The ID of the helm release"
  value       = helm_release.this.id
}
