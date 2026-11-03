variable "location" {
  type    = string
  default = "eastus"
}

variable "prefix" {
  type    = string
  default = "foundry"
}

variable "storage_sku" {
  type    = string
  default = "Standard_LRS"
}

variable "key_vault_sku" {
  type    = string
  default = "standard"
}

variable "tags" {
  type    = map(string)
  default = {}
}
