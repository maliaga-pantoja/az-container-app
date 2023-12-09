resource "azurerm_resource_group" "rg" {
  name     = "rsg-${var.PROJECT_NAME}"
  location = var.REGION
}

resource "azurerm_log_analytics_workspace" "law01" {
  name                = "law-${var.PROJECT_NAME}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 =  "PerGB2018"
  retention_in_days   = var.LAW_RETENTION
}

resource "azurerm_virtual_network" "vn" {
  name = "vnt-${var.PROJECT_NAME}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space = [ "10.10.0.0/24" ]
}

resource "azurerm_subnet" "snet" {
  name = "snt-${var.PROJECT_NAME}"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes = [ "10.10.0.1/24" ]
}

resource "azurerm_kubernetes_cluster" "aks01" {
  name                = "aks-${var.PROJECT_NAME}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "vault-aks-demo"
  private_cluster_enabled = true

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
    vnet_subnet_id = azurerm_subnet.snet.id
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks01.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks01.kube_config_raw

  sensitive = true
}