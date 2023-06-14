variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Container Registry. Only Alphanumeric characters allowed. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created."
}
variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}
variable "sku" {
  type        = string
  description = "(Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium."
}
variable "admin_enabled" {
  type        = bool
  description = "(Optional) Specifies whether the admin user is enabled. Defaults to false."
  default     = false
}
variable "tags" {
  type        = map(string)
  description = "(Required) A mapping of tags to assign to the resource."

  validation {
    condition     = contains(keys(var.tags), "description")
    error_message = "Tag description should be declared."
  }

  validation {
    condition     = contains(keys(var.tags), "product")
    error_message = "Tag product should be declared."
  }

  validation {
    condition     = contains(keys(var.tags), "service")
    error_message = "Tag service should be declared."
  }

  validation {
    condition     = contains(keys(var.tags), "instance")
    error_message = "Tag instance should be declared."
  }

  validation {
    condition     = contains(keys(var.tags), "cia")
    error_message = "Tag cia should be declared."
  }

  validation {
    condition     = contains(keys(var.tags), "channel")
    error_message = "Tag channel should be declared."
  }
}
variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether public network access is allowed for the container registry. Defaults to true."
  default     = false
}
variable "quarantine_policy_enabled" {
  type        = bool
  description = "Optional) Boolean value that indicates whether quarantine policy is enabled."
  default     = false
}
variable "zone_redundancy_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to false."
}
variable "export_policy_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Boolean value that indicates whether export policy is enabled. Defaults to true. In order to set it to false, make sure the public_network_access_enabled is also set to false."
}
variable "anonymous_pull_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry? This is only supported on resources with the Standard or Premium SKU."
}
variable "data_endpoint_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Whether to enable dedicated data endpoints for this Container Registry? This is only supported on resources with the Premium SKU."
}
variable "network_rule_bypass_option" {
  type        = string
  default     = "AzureServices"
  description = "(Optional) Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are None and AzureServices. Defaults to AzureServices."
}
variable "geo_replications" {
  type = list(object({
    location                  = optional(string)
    regional_endpoint_enabled = optional(bool)
    tags                      = optional(map(any))
  }))
  default = null
}
variable "identity_type" {
  type = object({
    type         = optional(string)
    identity_ids = optional(list(string))
  })
  description = "(Optional) The type of identity used for the managed cluster. Conflict with `client_id` and `client_secret`. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned`(to enable both). If `UserAssigned` or `SystemAssigned, UserAssigned` is set, an `identity_ids` must be set as well."
  default = {
    type         = ""
    identity_ids = []
  }
  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity_type.type)
    error_message = "`identity_type`'s possible values are `SystemAssigned`, `UserAssigned` OR `SystemAssigned, UserAssigned` to enable both"
  }
}
variable "encryption" {
  type = object({
    enabled            = optional(bool)
    identity_client_id = optional(string)
    key_vault_key_id   = optional(string)
  })
  default = null
}
variable "network_rule_set" {
  type = object({
    default_action = optional(string)
    ip_rule = optional(list(object({
      action   = optional(string)
      ip_range = optional(string)
    })))
    virtual_network = optional(list(object({
      action    = optional(string)
      subnet_id = optional(string)
    })))
  })
  default = null
}
variable "retention_policy" {
  type = object({
    days    = optional(number)
    enabled = optional(bool)
  })
  default = null
}
variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  default = null
}
variable "trust_policy" {
  type = object({
    enabled = optional(bool)
  })
  default = null
}
