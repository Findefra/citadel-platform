output "hub_id" {
  value = azurerm_ai_foundry.hub.id
}

output "hub_name" {
  value = azurerm_ai_foundry.hub.name
}

output "hub_principal_id" {
  value = azurerm_ai_foundry.hub.identity[0].principal_id
}
