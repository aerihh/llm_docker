# Remote state in Azure Blob Storage. State locking is automatic and native
# here: the azurerm backend takes a blob lease before writing, so concurrent
# `apply` runs block instead of corrupting state -- no DynamoDB-style lock
# table needed (that's an AWS S3 backend concept).
#
# Backend blocks cannot reference variables or resources, so the storage
# account/container for state must already exist (created once, by hand or in
# a bootstrap config) and its values are supplied at `terraform init` time via
# backend.hcl (see below), not hardcoded here.
terraform {
  backend "azurerm" {}
}
