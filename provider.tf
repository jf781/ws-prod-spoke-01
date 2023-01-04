provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}
  alias = "hub_main"
  subscription_id = var.subscription_id_hub
}

provider "azurerm" {
  features {}
  alias = "spoke_main"
  subscription_id = var.subscription_id_spoke
}
