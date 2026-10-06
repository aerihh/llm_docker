# Azure Authentication Variables
variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
}

variable "azure_client_id" {
  description = "Azure Service Principal Client ID"
  type        = string
  sensitive   = true
}

variable "azure_client_secret" {
  description = "Azure Service Principal Client Secret"
  type        = string
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  sensitive   = true
}

# General Variables
variable "azure_region" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "llm-docker-rg"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "llm-docker"
}

# Defender for Cloud
variable "enable_defender_for_containers" {
  description = "Enable Defender for Cloud's Containers plan (subscription-wide image/vuln scanning for ACR + AKS)"
  type        = bool
  default     = true
}

# AKS Workload Identity federation (assumes the AKS cluster already exists
# with the OIDC issuer and Workload Identity features enabled)
variable "aks_oidc_issuer_url" {
  description = "OIDC issuer URL of the AKS cluster (az aks show --query oidcIssuerProfile.issuerUrl)"
  type        = string
}

variable "workload_identity_namespace" {
  description = "Kubernetes namespace of the docqa ServiceAccount"
  type        = string
  default     = "docqa"
}

variable "workload_identity_service_account" {
  description = "Kubernetes ServiceAccount name used by the docqa Pods"
  type        = string
  default     = "docqa"
}
