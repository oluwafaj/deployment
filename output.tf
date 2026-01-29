output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "virtual_machine_name" {
  description = "The names of the created virtual machines"
  value       = azurerm_virtual_machine.main[*].name
} 

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.main.name
}

