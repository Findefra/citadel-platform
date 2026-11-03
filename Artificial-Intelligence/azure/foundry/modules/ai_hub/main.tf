# Supporting resources required by an AI Foundry hub
resource "azurerm_storage_account" "hub" {
  name                     = lower(replace("st${var.prefix}hub", "-", ""))
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = var.storage_sku
}

resource "azurerm_key_vault" "hub" {
  name                = lower(replace("kv-${var.prefix}-hub", "-", ""))
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.key_vault_sku
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "deployer" {
  key_vault_id = azurerm_key_vault.hub.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = ["Get", "Set", "List", "Delete"]
}

resource "azurerm_ai_foundry" "hub" {
  name                = "${var.prefix}-hub"
  resource_group_name = var.resource_group_name
  location            = var.location
  storage_account_id  = azurerm_storage_account.hub.id
  key_vault_id        = azurerm_key_vault.hub.id

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
