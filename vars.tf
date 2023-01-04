
variable "subnet_list" {
  description = "A list of subnets to be attached to the VNET. The variable should include a list of maps with the subnetName and prefix included."
  type        = list(any)

}
variable "prefix" {
  type = string
  description = "String that is used for the first part of the name."
}


variable "subscription_id_spoke" {
  type = string
  description = "Subscripion ID of Spoke"
}

variable "subscription_id_hub" {
  type = string
  description = "Subscripion ID of Hub"
}

 variable "location" {
   description = "The desired Azure region to be deployed to."
   type = string
 }
 
variable "vnet_address_space" {
  description = "The address space allocated to the VNET."
}

variable "tags" {
  type        = map(string)
  description = "Required tags with values that will be attached to deployed resources. Passed over as a map type."
}

variable "hub_routes" {
  type = list(string)
  description = "List the routes that can be applied to the VNET. That will route to the Hub."

}

variable "spoke_vnet_name" {
  type = string
  description = "Name of the spoke VNET."
}

variable "spoke_rg_name" {
  type = string
  description = "Name of the resource group for the spoke VNET."
}