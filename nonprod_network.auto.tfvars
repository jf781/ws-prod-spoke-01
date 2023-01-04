prefix = "Prod"
tags = {
    "BusinessUnit"        = "5678"
    "environment" 	      = "Prod"
    "location"            = "Central US"
}
location    ="centralus"
spoke_rg_name = "vnet"
spoke_vnet_name   = ""
hub_routes = ["0.0.0.0/0"]
vnet_address_space = "10.11.0.0/16"
subnet_list = [
  {
    subnet_name = "Data"
    prefix      = "10.11.10.0/24"
    nsg_map = [{
      name = "from*base"
      priority = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_ranges    = ["80","443","3389","22"]
      destination_port_range     = ""
      source_address_prefix      = "*"
      destination_address_prefix = "*"   
    
      },
      {
      name = "from*icmp"
      priority = 102
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_ranges    = []
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
     }
    ]
  },
  {
    subnet_name = "App"
    prefix      = "10.11.11.0/24"
    nsg_map = [{
      name = "from*base"
      priority = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_ranges    = ["80","443","3389","22"]
      destination_port_range     = ""
      source_address_prefix      = "*"
      destination_address_prefix = "*"   
    },
    {
      name = "from*icmp"
      priority = 102
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_ranges    = []
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
    ]
  }
]