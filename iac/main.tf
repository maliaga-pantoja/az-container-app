resource "azurerm_resource_group" "rg" {
  name     = "rsg-${var.PROJECT_NAME}"
  location = var.REGION
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "law-${var.PROJECT_NAME}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 =  "PerGB2018"
  retention_in_days   = var.LAW_RETENTION
}

resource "azurerm_container_app_environment" "example" {
  name                       = "cae-${var.PROJECT_NAME}"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
}
resource "azurerm_container_app" "example" {
  name                         = "cap-${var.PROJECT_NAME}"
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = azurerm_resource_group.rg.name
  revision_mode                = "Multiple"

  template {
    container {
      name   = "container-${var.PROJECT_NAME}"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest2" #"${var.IMAGE_NAME}:${var.IMAGE_TAG}"
      cpu    = var.CONTAINER_CPU
      memory = var.CONTAINER_MEMORY
    }
  }

  ingress {
    allow_insecure_connections = false
    external_enabled = true
    target_port = 80
    transport = "http"
    traffic_weight {
      percentage = 100
      latest_revision = true
    }
  }
}