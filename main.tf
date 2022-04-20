terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.48.0"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "slow-sinatra-kube-deploy-rg"
  location = "westeurope"
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "slow-sinatra-kube-deploy-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "slow-sinatra-kube-deploy-cluster"

  default_node_pool {
    name       = "default"
    node_count = "2"
    vm_size    = "standard_b2ms"
  }

  identity {
    type = "SystemAssigned"
  }
}
