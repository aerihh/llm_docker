resource "azurerm_user_assigned_identity" "docqa" {
  name                = "id-docqa-workload"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

# Links the identity to the docqa Kubernetes ServiceAccount via AKS Workload
# Identity federation. Requires the AKS cluster to already have the OIDC
# issuer and Workload Identity features enabled (var.aks_oidc_issuer_url).
resource "azurerm_federated_identity_credential" "docqa" {
  name                = "fic-docqa-workload"
  resource_group_name = azurerm_resource_group.main.name
  parent_id           = azurerm_user_assigned_identity.docqa.id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.aks_oidc_issuer_url
  subject             = "system:serviceaccount:${var.workload_identity_namespace}:${var.workload_identity_service_account}"
}

# Least-privilege read access, scoped to only the model-artifacts container
# (not the whole storage account).
resource "azurerm_role_assignment" "docqa_blob_reader" {
  scope                = azurerm_storage_container.model_artifacts.resource_manager_id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_user_assigned_identity.docqa.principal_id
}
