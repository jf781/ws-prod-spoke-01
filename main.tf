#---------------------------------------------------------------
# Unmanaged Resources
#---------------------------------------------------------------

data "tfe_outputs" "az1_hub" {
  organization = "berlin-packaging-infra"
  workspace = "ws-az1-network_hub"
}

data "tfe_outputs" "ws_shared_services_core" {
  organization = "berlin-packaging-infra"
  workspace = "ws-shared-services-core"
}

#---------------------------------------------------------------
# Managed Resources
#---------------------------------------------------------------

# Network Resource Group
module "rg_vnet" {
  source              = "app.terraform.io/Joe-Demo/module-resource-group/azurerm"
  resource_group_name = var.spoke_rg_name
  tags                = var.tags
  location            = var.location
  prefix              = var.prefix
  lock                = local.lock
}

# Spoke Vnet
module "spoke_networking" {
  providers = {
    azurerm.spoke = azurerm.spoke_main
    azurerm.hub = azurerm.hub_main
  }
  source              = "app.terraform.io/berlin-packaging-infra/module-spoke/azurerm"
  tags                = var.tags
  use_remote_gateways = true 
  disable_bgp_propagation     = true #False will push bgp into the spoke
  name_prefix         = var.prefix
  subnet_list         = var.subnet_list
  resource_group_name = module.rg_vnet.resource_group_name
  location            = var.location
  vnet_name           = var.spoke_vnet_name
  vnet_address_space  = var.vnet_address_space
  hub_routes          = var.hub_routes
  dns_servers         = ["10.48.9.41", "10.0.0.41", "10.0.0.42"]
  firewall_ip         = data.tfe_outputs.az1_hub.values.azurefirewall_ip
  hub_vnet_rg         = data.tfe_outputs.az1_hub.values.hub_vnet_rg
  hub_vnet_name       = data.tfe_outputs.az1_hub.values.hub_vnet_name
  hub_vnet_id         = data.tfe_outputs.az1_hub.values.hub_vnet_id
  hub_vnet_gw_rt_name   = data.tfe_outputs.az1_hub.values.hub_vnet_gw_rt_name
  log_analytics_workspace_location     = data.tfe_outputs.ws_shared_services_core.values.log_analytics_workspace_location
  log_analytics_workspace_id           = data.tfe_outputs.ws_shared_services_core.values.log_analytics_id
  log_analytics_workspace_workspace_id = data.tfe_outputs.ws_shared_services_core.values.log_analytics_workspace_id
  storage_account_id                   = data.tfe_outputs.ws_shared_services_core.values.storage_act_log_id
  network_watcher_name                 = "NetworkWatcher_centralus" 
}