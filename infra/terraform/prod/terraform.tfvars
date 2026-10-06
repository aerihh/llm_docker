# Azure Authentication - FILL IN YOUR VALUES
# Get these from your Azure Service Principal
azure_subscription_id = "your-subscription-id-here"
azure_client_id       = "your-client-id-here"
azure_client_secret   = "your-client-secret-here"
azure_tenant_id       = "your-tenant-id-here"

# General Configuration
azure_region        = "East US"
resource_group_name = "llm-docker-rg"
environment         = "dev"
project_name        = "llm-docker"

# Get with: az aks show -g <aks-rg> -n <aks-name> --query oidcIssuerProfile.issuerUrl -o tsv
aks_oidc_issuer_url               = "https://<region>.oic.prod-aks.azure.com/<tenant-id>/<guid>/"
workload_identity_namespace       = "docqa"
workload_identity_service_account = "docqa"
enable_defender_for_containers    = true
