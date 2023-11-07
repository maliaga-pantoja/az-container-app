variable "PROJECT_NAME" {
  type = string
  description = "project name: cant contain special characters"
    validation {
      condition = can(regex("^[^<>'\"/;`%]*$", var.PROJECT_NAME))
      error_message = "value"
    }
}

variable "REGION" {
  type = string
  description = "Region allowed:  EASTUS, EASTUS2"
  validation {
    condition = contains(["EASTUS", "EASTUS2"], var.REGION)
    error_message = "REGION NOW ALLOWED"
  }
}

variable "LAW_RETENTION" {
  type = number
  default = 30
  description = "Log analytics workspace retention days"
}

variable "IMAGE_NAME" {
  type = string
}

variable "IMAGE_TAG" {
  type = string
}

variable "CONTAINER_CPU" {
  type = number
  default = 0.25
}

variable "CONTAINER_MEMORY" {
    type = string
    default = "0.5Gi"
}