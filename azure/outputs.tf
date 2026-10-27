output "web_url" {
  value = "http://${azurerm_public_ip.web.ip_address}"
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.web.id
}

output "bucket_name" {
  value = azurerm_storage_account.this.name
}

output "resource_group" {
  value = azurerm_resource_group.this.name
}
