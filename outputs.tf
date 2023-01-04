output "subnet_id" {
  value = module.spoke_networking.subnet_id
  description = "List(string) Spoke Subnet IDs"
}

output "vnet_id" {
  value = module.spoke_networking.vnet_id
  description = "(String) Spoke Vnet ID. "
}