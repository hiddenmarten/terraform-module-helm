# Terraform Helm Module with Template Diff Tracking

A Terraform module that wraps the `helm_release` resource and `helm_template` data source to provide enhanced visibility into Helm chart manifest changes during Terraform planning and deployment.

## Why This Module Exists

When deploying Helm charts with Terraform's native `helm_release` resource, engineers often face a common challenge: **lack of visibility into the actual Kubernetes manifest changes** that will be applied. The standard `helm_release` resource only shows high-level changes to Terraform-managed attributes, not the detailed differences in the rendered Kubernetes manifests.

This module addresses this limitation by:

1. **Rendering templates in advance** using the `helm_template` data source
2. **Storing rendered manifests** in a `null_resource` trigger
3. **Enabling diff visibility** during `terraform plan` operations
4. **Maintaining full compatibility** with all `helm_release` functionality

## Key Benefits

### 🔍 **Enhanced Visibility**
- See actual Kubernetes manifest diffs during `terraform plan`
- Understand exactly what will change in your cluster before applying
- Compare rendered manifests between plan runs

### 🛡️ **Safety & Confidence**
- Review manifest changes before deployment
- Catch unintended modifications early
- Reduce deployment surprises and rollbacks

### 📊 **Better Change Management**
- Track manifest evolution over time
- Correlate Terraform changes with actual Kubernetes resource modifications
- Improve audit trails and compliance

### 🔧 **Full Helm Compatibility**
- Supports all `helm_release` arguments and features
- Maintains exact same interface as native Helm provider
- Drop-in replacement for existing `helm_release` resources

## How It Works

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Variables     │───▶│  helm_template   │───▶│  null_resource  │
│                 │    │   (renders)      │    │   (stores)      │
└─────────────────┘    └──────────────────┘    └─────────────────┘
         │                                               │
         ▼                                               ▼
┌─────────────────┐                              ┌─────────────────┐
│  helm_release   │                              │ Terraform Plan  │
│   (deploys)     │                              │  Shows Diffs    │
└─────────────────┘                              └─────────────────┘
```

1. **Template Rendering**: `helm_template` data source renders the Helm chart with your values
2. **State Tracking**: `null_resource` stores the rendered manifest as a trigger
3. **Diff Detection**: Terraform detects changes in rendered manifests during planning
4. **Chart Deployment**: `helm_release` deploys the chart to your cluster

## Usage

### Basic Example

```hcl
module "my_helm_chart" {
  source = "path/to/this/module"

  name       = "my-application"
  repository = "https://charts.example.com"
  chart      = "my-app"
  namespace  = "production"

  values = {
    image = {
      repository = "my-app"
      tag        = "v1.2.3"
    }
    replicas = 3
  }
}
```

### Advanced Example with All Features

```hcl
module "complex_helm_chart" {
  source = "path/to/this/module"

  # Chart identification
  name            = "complex-app"
  repository      = "oci://registry.example.com/helm-charts"
  chart           = "complex-application"
  chart_version   = "2.5.1"
  namespace       = "production"
  create_namespace = true

  # Deployment behavior
  atomic          = true
  wait            = true
  timeout         = 600

  # Values configuration
  values = {
    global = {
      environment = "production"
    }
    database = {
      host = "prod-db.example.com"
      port = 5432
    }
  }

  # Individual value overrides
  set = [
    {
      name  = "image.tag"
      value = "v2.5.1"
    }
  ]

  # Sensitive values
  set_sensitive = [
    {
      name  = "database.password"
      value = var.db_password
    }
  ]


  # Post-processing
  postrender = {
    binary_path = "/usr/local/bin/kustomize"
    args        = ["build", "--enable-helm"]
  }
}
```

## Module Outputs

The module provides all standard `helm_release` outputs plus additional template information:

```hcl
# Standard helm_release outputs
output "release_name" {
  value = module.my_helm_chart.name
}

output "release_status" {
  value = module.my_helm_chart.status
}

output "manifest" {
  value = module.my_helm_chart.manifest
}

# Additional outputs for debugging
output "namespace" {
  value = module.my_helm_chart.namespace
}

output "chart_version" {
  value = module.my_helm_chart.version
}
```

## Comparison with Standard helm_release

| Feature | Standard `helm_release` | This Module |
|---------|------------------------|-------------|
| Helm chart deployment | ✅ | ✅ |
| All helm_release arguments | ✅ | ✅ |
| Terraform plan visibility | ❌ Limited | ✅ **Full manifest diffs** |
| Template validation | ❌ | ✅ Pre-deployment |
| Change preview | ❌ | ✅ **Complete preview** |
| State overhead | Minimal | Small (manifest storage) |

## When to Use This Module

### ✅ **Ideal for:**
- Production environments where change visibility is critical
- Complex Helm charts with many interdependent resources
- Teams requiring approval workflows for manifest changes
- Debugging template rendering issues
- Compliance environments requiring change documentation

### ⚠️ **Consider alternatives for:**
- Simple, single-resource charts where overhead isn't justified
- Environments with very limited Terraform state storage
- Charts with extremely large manifests (>1MB rendered)

## Requirements

- Terraform >= 1.0
- Helm Provider >= 2.0
- Kubernetes cluster access for Helm operations

## Contributing

This module maintains compatibility with all `helm_release` and `helm_template` provider features. When adding new variables, ensure they're supported by both resources where applicable.
