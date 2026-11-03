resource "azurerm_resource_group" "ai" {
  name     = "rg-${var.prefix}"
  location = var.location
  tags     = var.tags
}

module "ai_hub" {
  source              = "./modules/ai_hub"
  resource_group_name = azurerm_resource_group.ai.name
  location            = var.location
  prefix              = var.prefix
  storage_sku         = var.storage_sku
  key_vault_sku       = var.key_vault_sku
  tags                = var.tags
}

module "ai_project" {
  source              = "./modules/ai_project"
  resource_group_name = azurerm_resource_group.ai.name
  location            = var.location
  prefix              = var.prefix
  ai_hub_id           = module.ai_hub.hub_id
  tags                = var.tags
}
