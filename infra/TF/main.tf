terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = ">= 2.0"
        }
    }
    required_version = ">= 0.14.9"
}

provider "azurerm" {
    features {}
}

data "azurerm_client_config" "current" {}

variable appName {}
variable envName {}

locals {
  rgName = "${var.appName}-${var.envName}-rg"
  siteName = "${var.appName}-${var.envName}-site"
  hostName = "${var.appName}-${var.envName}-plan"
}


resource "azurerm_resource_group" "rg" {
    name = local.rgName
    location = "westeurope"
}

resource "azurerm_app_service_plan" "plan" {
    name                = local.hostName
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    kind                = "Linux"
    reserved            = true
    sku {
      tier = "Standard"
      size = "S1"
    }
}

resource "azurerm_app_service" "myApp" {
    name                = local.siteName
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    app_service_plan_id = azurerm_app_service_plan.plan.id
    
    site_config {
        linux_fx_version = "DOTNETCORE|7.0"
        app_command_line = "dotnet mhChat.dll"
    }
    
    app_settings = {
        "Key" = "Value"
        "Key" = "Value"
    }
    identity {
        type = "SystemAssigned"
    }
}



