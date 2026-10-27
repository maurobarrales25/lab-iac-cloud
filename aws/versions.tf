terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  # Configuración parcial: los valores están en backend.hcl
  backend "s3" {}
}

provider "aws" {
  region = var.region

  # Etiquetas aplicadas a TODOS los recursos
  default_tags {
    tags = local.tags
  }
}
