resource "azurerm_container_registry" "this" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  tags                          = var.tags
  public_network_access_enabled = var.public_network_access_enabled
  quarantine_policy_enabled     = var.quarantine_policy_enabled
  zone_redundancy_enabled       = var.zone_redundancy_enabled
  export_policy_enabled         = var.export_policy_enabled
  anonymous_pull_enabled        = var.anonymous_pull_enabled
  data_endpoint_enabled         = var.data_endpoint_enabled
  network_rule_bypass_option    = var.network_rule_bypass_option

  dynamic "georeplications" {
    for_each = var.geo_replications != null ? var.geo_replications : []
    content {
      location                  = georeplications.value.location
      regional_endpoint_enabled = georeplications.value.regional_endpoint_enabled
      tags                      = georeplications.value.tags
    }
  }
  dynamic "identity" {
    for_each = var.identity_type != null ? ["identity"] : []
    content {
      type         = var.identity_type.type
      identity_ids = var.identity_type.identity_ids
    }
  }
  dynamic "encryption" {
    for_each = var.encryption != null ? ["encryption"] : []
    content {
      enabled            = var.encryption.enabled
      identity_client_id = var.encryption.identity_client_id
      key_vault_key_id   = var.encryption.key_vault_key_id
    }
  }
  dynamic "network_rule_set" {
    for_each = var.network_rule_set != null ? ["network_rule_set"] : []
    content {
      default_action = var.network_rule_set.default_action
      dynamic "ip_rule" {
        for_each = var.network_rule_set.ip_rule != null ? var.network_rule_set.ip_rule : []
        content {
          action   = ip_rule.value.action
          ip_range = ip_rule.value.ip_range
        }
      }
      dynamic "virtual_network" {
        for_each = var.network_rule_set.virtual_network != null ? var.network_rule_set.virtual_network : []
        content {
          action    = virtual_network.value.action
          subnet_id = virtual_network.value.subnet_id
        }
      }
    }

  }
  dynamic "retention_policy" {
    for_each = var.retention_policy != null ? ["retention_policy"] : []
    content {
      days    = var.retention_policy.days
      enabled = var.retention_policy.enabled
    }
  }
  dynamic "timeouts" {
    for_each = var.timeouts != null ? ["timeouts"] : []
    content {
      create = var.timeouts.create
      delete = var.timeouts.delete
      read   = var.timeouts.read
      update = var.timeouts.update
    }
  }
  dynamic "trust_policy" {
    for_each = var.trust_policy != null ? ["trust_policy"] : []
    content {
      enabled = var.trust_policy.enabled
    }
  }
}
