resource "azurerm_ai_foundry_project" "project" {
  name               = "${var.prefix}-project"
  ai_services_hub_id = var.ai_hub_id
  location           = var.location
  tags               = var.tags
}
