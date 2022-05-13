terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
    #version = "3.0.2"
    features {}
}

resource "azurerm_resource_group" "rg_name" {
    name = "jtaylor_resource_grp"
    location = "East US 2"
}

resource "azurerm_container_group" "cg_name" {
    name                    = "weatherapi"
    location                = azurerm_resource_group.rg_name.location
    resource_group_name     = azurerm_resource_group.rg_name.name

    ip_address_type         = "Public"
    dns_name_label          = "jtweatherAPIpersonal"
    os_type                 = "Linux"

    container {
        name                = "weatherapi"
        image               = "j1taylor1/weatherapi"
        cpu                 = "1"
        memory              = "1"

        ports {
            port            = 80
            protocol        = "TCP"
        }
    }
}



