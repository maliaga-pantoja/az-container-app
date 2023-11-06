resource "azurerm_resource_group" "rg" {
  name     = "rsg-${var.PROJECT_NAME}"
  location = var.REGION
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "law-${var.PROJECT_NAME}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.LAW_RETENTION
  retention_in_days   = 30
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
  revision_mode                = "Single"

  template {
    container {
      name   = "container-${var.PROJECT_NAME}"
      image  = "${var.IMAGE_NAME}:${var.IMAGE_TAG}"
      cpu    = var.CONTAINER_CPU
      memory = var.CONTAINER_MEMORY
    }
  }
}