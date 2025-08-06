terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
  }
}
