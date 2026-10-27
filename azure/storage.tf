resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Nombre: 3 a 24 caracteres, solo minúsculas y números, único en Azure
resource "azurerm_storage_account" "this" {
  name                            = "st${replace(var.prefix, "-", "")}${random_string.suffix.result}"
  resource_group_name             = azurerm_resource_group.this.name
  location                        = azurerm_resource_group.this.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  tags                            = local.tags
}

resource "azurerm_storage_container" "evidencias" {
  name                  = "evidencias"
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}

resource "azurerm_storage_blob" "evidencia" {
  name                   = "evidencia.txt"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.evidencias.name
  type                   = "Block"
  source_content         = "Creado por IaC | owner=${var.owner} | env=${var.environment}\n"
}
