# Azurerm Container Registry

Este módulo será responsável criar Container Registry.

# Example usage
```
data "azurerm_resource_group" "rsg" {
  for_each = { for index, acr_list in var.acr_list : index => acr_list }
  name     = each.value.resource_group_name
}
module "naming_convention" {
  source      = "terraform.infra.prod.gms.corp/pagoNXT/naming-convention/pagonxt"
  version     = "0.0.5"
  for_each    = { for index, acr_list in var.acr_list : index => acr_list.naming_convention if acr_list.name == null }
  type        = each.value.type != null ? each.value.type : "resource"
  gms_product = "Container registry"
  function    = each.value.function
  application = each.value.application
  region      = each.value.region != null ? each.value.region : data.azurerm_resource_group.rsg[each.key].location
  env         = each.value.env
}
module "acr" {
  source                        = "terraform.infra.prod.gms.corp/pagoNXT/acr/azurerm"
  version                       = "0.0.1"
  for_each                      = { for index, acr_list in var.acr_list : index => acr_list }
  name                          = each.value.name != null ? each.value.name : module.naming_convention[each.key].name
  resource_group_name           = data.azurerm_resource_group.rsg[each.key].name
  location                      = data.azurerm_resource_group.rsg[each.key].location
  sku                           = lookup(each.value, "sku", var.sku)
  admin_enabled                 = lookup(each.value, "admin_enabled", var.admin_enabled)
  public_network_access_enabled = lookup(each.value, "public_network_access_enabled", var.public_network_access_enabled)
  quarantine_policy_enabled     = lookup(each.value, "quarantine_policy_enabled", var.quarantine_policy_enabled)
  zone_redundancy_enabled       = lookup(each.value, "zone_redundancy_enabled", var.zone_redundancy_enabled)
  export_policy_enabled         = lookup(each.value, "export_policy_enabled", var.export_policy_enabled)
  anonymous_pull_enabled        = lookup(each.value, "anonymous_pull_enabled", var.anonymous_pull_enabled)
  data_endpoint_enabled         = lookup(each.value, "data_endpoint_enabled", var.data_endpoint_enabled)
  network_rule_bypass_option    = lookup(each.value, "network_rule_bypass_option", var.network_rule_bypass_option)
  geo_replications              = lookup(each.value, "geo_replications", var.geo_replications)
  identity_type                 = lookup(each.value, "identity_type", var.identity_type)
  encryption                    = lookup(each.value, "encryption", var.encryption)
  network_rule_set              = lookup(each.value, "network_rule_set", var.network_rule_set)
  retention_policy              = lookup(each.value, "retention_policy", var.retention_policy)
  timeouts                      = lookup(each.value, "timeouts", var.timeouts)
  trust_policy                  = lookup(each.value, "trust_policy", var.trust_policy)
  tags = merge(
    { "tracking_code" = "${each.value.name != null ? each.value.name : module.naming_convention[each.key].name}" },
    { "pdc" = "${formatdate("YYYYMMDD", timestamp())}" },
    var.tags
  )
}

```

# Exemplo das variáveis no Terraform TFVARS
```
acr_list = {
  "acr01" = {
    admin_enabled = false
    identity_type = {
      type = "SystemAssigned"
    }
    naming_convention = {
      function    = "generic",
      application = "Platform",
      region      = "eastus2",
      env         = "development",
      product     = "Container registry"
    }
    network_rule_set = {
      default_action = "Deny"
      ip_rule = [
        {
          action   = "Allow"
          ip_range = "146.112.0.0/16"
        },
        {
          action   = "Allow"
          ip_range = "155.190.0.0/16"
        }
      ]
    }
    public_network_access_enabled = true
    resource_group_name           = "<nome do resource group>"
    sku                           = "Premium"
    timeouts = {
      create = "30m"
      delete = "30m"
      read   = "30m"
      update = "30m"
    }
    trust_policy = {
      enabled = false
    }
    zone_redundancy_enabled = false
  }
}
tags = { 
  "description" = "container registry dev zu2",
  "product" = "container registry",
  "service" = "container registry dev zu2",
  "instance" = "dev",
  "cia" = "CMM",
  "channel" = "iac"
}

```

***
##### Changelog
###### [0.0.1] - 2023-03-27
- Create the module
