resource "helm_release" "this" {
  repository                 = var.repository
  chart                      = var.chart
  version                    = var.chart_version
  name                       = var.name
  namespace                  = var.namespace
  create_namespace           = var.create_namespace
  render_subchart_notes      = var.render_subchart_notes
  disable_openapi_validation = var.disable_openapi_validation
  values                     = [yamlencode(var.values)]
  
  atomic                     = var.atomic
  cleanup_on_fail            = var.cleanup_on_fail
  dependency_update          = var.dependency_update
  description                = var.description
  devel                      = var.devel
  force_update               = var.force_update
  keyring                    = var.keyring
  lint                       = var.lint
  max_history                = var.max_history
  pass_credentials           = var.pass_credentials
  recreate_pods              = var.recreate_pods
  replace                    = var.replace
  repository_ca_file         = var.repository_ca_file
  repository_cert_file       = var.repository_cert_file
  repository_key_file        = var.repository_key_file
  repository_password        = var.repository_password
  repository_username        = var.repository_username
  reset_values               = var.reset_values
  reuse_values               = var.reuse_values
  skip_crds                  = var.skip_crds
  timeout                    = var.timeout
  verify                     = var.verify
  wait                       = var.wait
  wait_for_jobs              = var.wait_for_jobs
  disable_webhooks           = var.disable_webhooks
  
  dynamic "postrender" {
    for_each = var.postrender != null ? [1] : []
    content {
      binary_path = var.postrender.binary_path
      args        = var.postrender.args
    }
  }
  
  dynamic "set" {
    for_each = var.set
    content {
      name  = set.value["name"]
      value = set.value["value"]
    }
  }
  
  dynamic "set_sensitive" {
    for_each = var.set_sensitive
    content {
      name  = set_sensitive.value["name"]
      value = set_sensitive.value["value"]
    }
  }
  
  dynamic "set_list" {
    for_each = var.set_list
    content {
      name  = set_list.value["name"]
      value = set_list.value["value"]
    }
  }
  
  dynamic "set_string" {
    for_each = var.set_string
    content {
      name  = set_string.value["name"]
      value = set_string.value["value"]
    }
  }
}
