resource "azurerm_container_registry" "main" {
  name                = "acr${replace(var.project_name, "-", "")}${random_string.storage_suffix.result}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Premium" # Defender vulnerability scanning requires Premium
  admin_enabled       = false

  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

# Defender for Cloud's container vulnerability assessment is a SUBSCRIPTION-level
# setting (the "Containers" plan), not a per-registry resource -- enabling it
# turns on image scanning for every ACR and AKS cluster in the subscription and
# has its own cost. Toggle with var.enable_defender_for_containers.
resource "azurerm_security_center_subscription_pricing" "containers" {
  count         = var.enable_defender_for_containers ? 1 : 0
  tier          = "Standard"
  resource_type = "Containers"
}
