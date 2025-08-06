variable "chart" {
  description = "Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if repository is specified. It is also possible to use the <repository>/<chart> format here if you are running Terraform on a system that the repository has been added to with helm repo add but this is not recommended."
  type        = string
}

variable "name" {
  description = "Release name. The length must not be longer than 53 characters."
  type        = string
}

variable "atomic" {
  description = "If set, installation process purges chart on fail. The wait flag will be set automatically if atomic is used."
  type        = bool
  default     = false
}

variable "cleanup_on_fail" {
  description = "Allow deletion of new resources created in this upgrade when upgrade fails."
  type        = bool
  default     = false
}

variable "create_namespace" {
  description = "Create the namespace if it does not yet exist. Defaults to false."
  type        = bool
  default     = false
}

variable "dependency_update" {
  description = "Runs helm dependency update before installing the chart."
  type        = bool
  default     = false
}

variable "description" {
  description = "Set release description attribute (visible in the history)."
  type        = string
  default     = null
}

variable "devel" {
  description = "Use chart development versions, too. Equivalent to version '>0.0.0-0'. If version is set, this is ignored."
  type        = bool
  default     = false
}

variable "repository" {
  description = "Repository URL where to locate the requested chart."
  type        = string
  default     = null
}

variable "force_update" {
  description = "Force resource update through delete/recreate if needed."
  type        = bool
  default     = false
}

variable "keyring" {
  description = "Location of public keys used for verification. Used only if verify is true."
  type        = string
  default     = null
}

variable "lint" {
  description = "Run the helm chart linter during the plan."
  type        = bool
  default     = false
}

variable "max_history" {
  description = "Maximum number of release versions stored per release."
  type        = number
  default     = 0
}

variable "chart_version" {
  description = "Specify the exact chart version to install. If this is not specified, the latest version is installed. helm_release will not automatically grab the latest release, version must explicitly be set."
  type        = string
  default     = null
}

variable "kubernetes_version" {
  description = "Version of kubernetes used for helm template."
  type        = string
  default     = null
}

variable "pass_credentials" {
  description = "Pass credentials to all domains."
  type        = bool
  default     = false
}

variable "postrender" {
  description = "Configure a command to run after helm renders the manifest which can alter the manifest contents."
  type = object({
    binary_path = string
    args        = optional(list(string))
  })
  default = null
}

variable "recreate_pods" {
  description = "Perform pods restart during upgrade/rollback."
  type        = bool
  default     = false
}

variable "render_subchart_notes" {
  description = "If set, render subchart notes along with the parent."
  type        = bool
  default     = true
}

variable "replace" {
  description = "Re-use the given name, only if that name is a deleted release which remains in the history. This is unsafe in production."
  type        = bool
  default     = false
}

variable "repository_ca_file" {
  description = "The Repositories CA File."
  type        = string
  default     = null
}

variable "repository_cert_file" {
  description = "The repositories cert file."
  type        = string
  default     = null
}

variable "repository_key_file" {
  description = "The repositories cert key file."
  type        = string
  default     = null
}

variable "repository_password" {
  description = "Password for HTTP basic authentication against the repository."
  type        = string
  default     = null
  sensitive   = true
}

variable "repository_username" {
  description = "Username for HTTP basic authentication against the repository."
  type        = string
  default     = null
}

variable "reset_values" {
  description = "When upgrading, reset the values to the ones built into the chart."
  type        = bool
  default     = false
}

variable "reuse_values" {
  description = "When upgrading, reuse the last release's values and merge in any overrides. If 'reset_values' is specified, this is ignored."
  type        = bool
  default     = false
}

variable "set" {
  description = "Value block with custom values to be merged with the values yaml."
  type = list(object({
    name  = string
    value = string
  }))
  default = null
}

variable "set_sensitive" {
  description = "Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff."
  type = list(object({
    name  = string
    value = string
  }))
  default   = null
  sensitive = true
}

variable "namespace" {
  description = "The namespace to install the release into. Defaults to default."
  type        = string
  default     = "default"
}

variable "skip_crds" {
  description = "If set, no CRDs will be installed. By default, CRDs are installed if not already present."
  type        = bool
  default     = false
}

variable "timeout" {
  description = "Time in seconds to wait for any individual kubernetes operation (like Jobs for hooks). Defaults to 300 seconds."
  type        = number
  default     = 300
}

variable "values" {
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
  type        = any
  default     = {}
}

variable "verify" {
  description = "Verify the package before installing it. Helm uses a provenance file to verify the integrity of the chart; this must be hosted alongside the chart."
  type        = bool
  default     = false
}

variable "wait" {
  description = "Will wait until all resources are in a ready state before marking the release as successful. It will wait for as long as timeout. Defaults to true."
  type        = bool
  default     = true
}

variable "wait_for_jobs" {
  description = "If wait is enabled, will wait until all Jobs have been completed before marking the release as successful. It will wait for as long as timeout. Defaults to false."
  type        = bool
  default     = false
}

variable "disable_openapi_validation" {
  description = "If set, the installation process will not validate rendered templates against the Kubernetes OpenAPI Schema."
  type        = bool
  default     = false
}

variable "disable_webhooks" {
  description = "Prevent hooks from running."
  type        = bool
  default     = false
}

variable "set_list" {
  description = "Value block with list of custom values to be merged with the values yaml."
  type = list(object({
    name  = string
    value = list(string)
  }))
  default = null
}
