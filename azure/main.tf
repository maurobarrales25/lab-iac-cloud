locals {
  name = "${var.prefix}-${var.environment}"

  tags = {
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "IaC"
    Course      = "UCU-Cloud"
    Lab         = "v2"
  }

  user_data = templatefile("${path.module}/../shared/web.sh.tftpl", {
    mensaje     = var.mensaje
    environment = var.environment
    cloud       = "Azure"
    bucket      = azurerm_storage_account.this.name
    owner       = var.owner
  })
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.name}"
  location = var.location
  tags     = local.tags
}
