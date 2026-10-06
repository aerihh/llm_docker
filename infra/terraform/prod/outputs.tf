output "resource_group_id" {
  description = "ID of the created Resource Group"
  value       = azurerm_resource_group.main.id
}

output "resource_group_name" {
  description = "Name of the created Resource Group"
  value       = azurerm_resource_group.main.name
}

output "azure_region" {
  description = "Azure region where resources are deployed"
  value       = azurerm_resource_group.main.location
}

output "storage_account_name" {
  description = "Name of the model artifacts storage account"
  value       = azurerm_storage_account.model_artifacts.name
}

output "model_artifacts_container_id" {
  description = "Resource Manager ID of the model-artifacts blob container"
  value       = azurerm_storage_container.model_artifacts.resource_manager_id
}

output "container_registry_login_server" {
  description = "Login server URL of the Azure Container Registry"
  value       = azurerm_container_registry.main.login_server
}

output "docqa_identity_client_id" {
  description = "Client ID of the docqa user-assigned managed identity (used in the Pod's azure.workload.identity/client-id annotation)"
  value       = azurerm_user_assigned_identity.docqa.client_id
}
