terraform {
  required_version = ">= 1.10"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  # Configuración parcial: los valores están en backend.hcl
  backend "azurerm" {}
}

# La suscripción se toma de la variable de entorno ARM_SUBSCRIPTION_ID
provider "azurerm" {
  features {}
}
