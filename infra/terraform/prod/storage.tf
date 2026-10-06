# Random suffix so the globally-unique storage account name doesn't collide
resource "random_string" "storage_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_storage_account" "model_artifacts" {
  name                     = "st${replace(var.project_name, "-", "")}${random_string.storage_suffix.result}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  # Encryption at rest: Microsoft-managed keys are on by default; this adds
  # a second, independent layer of encryption for defense in depth.
  infrastructure_encryption_enabled = true

  # Anonymous/public access disabled at the account level -- no container
  # or blob in this account can ever be made public, even by mistake.
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = true

  blob_properties {
    versioning_enabled = true
  }

  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

resource "azurerm_storage_container" "model_artifacts" {
  name                  = "model-artifacts"
  storage_account_name  = azurerm_storage_account.model_artifacts.name
  container_access_type = "private"
}
