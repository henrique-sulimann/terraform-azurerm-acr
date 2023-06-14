# terraform-azurerm-acr - Azure Container Registry

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.0.0/docs/resources/container_registry) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | (Optional) Specifies whether the admin user is enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_anonymous_pull_enabled"></a> [anonymous\_pull\_enabled](#input\_anonymous\_pull\_enabled) | (Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry? This is only supported on resources with the Standard or Premium SKU. | `bool` | `false` | no |
| <a name="input_data_endpoint_enabled"></a> [data\_endpoint\_enabled](#input\_data\_endpoint\_enabled) | (Optional) Whether to enable dedicated data endpoints for this Container Registry? This is only supported on resources with the Premium SKU. | `bool` | `false` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | n/a | <pre>object({<br>    enabled            = optional(bool)<br>    identity_client_id = optional(string)<br>    key_vault_key_id   = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_export_policy_enabled"></a> [export\_policy\_enabled](#input\_export\_policy\_enabled) | (Optional) Boolean value that indicates whether export policy is enabled. Defaults to true. In order to set it to false, make sure the public\_network\_access\_enabled is also set to false. | `bool` | `false` | no |
| <a name="input_geo_replications"></a> [geo\_replications](#input\_geo\_replications) | n/a | <pre>list(object({<br>    location                  = optional(string)<br>    regional_endpoint_enabled = optional(bool)<br>    tags                      = optional(map(any))<br>  }))</pre> | `null` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | (Optional) The type of identity used for the managed cluster. Conflict with `client_id` and `client_secret`. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned`(to enable both). If `UserAssigned` or `SystemAssigned, UserAssigned` is set, an `identity_ids` must be set as well. | <pre>object({<br>    type         = optional(string)<br>    identity_ids = optional(list(string))<br>  })</pre> | <pre>{<br>  "identity_ids": [],<br>  "type": ""<br>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the Container Registry. Only Alphanumeric characters allowed. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_network_rule_bypass_option"></a> [network\_rule\_bypass\_option](#input\_network\_rule\_bypass\_option) | (Optional) Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are None and AzureServices. Defaults to AzureServices. | `string` | `"AzureServices"` | no |
| <a name="input_network_rule_set"></a> [network\_rule\_set](#input\_network\_rule\_set) | n/a | <pre>object({<br>    default_action = optional(string)<br>    ip_rule = optional(list(object({<br>      action   = optional(string)<br>      ip_range = optional(string)<br>    })))<br>    virtual_network = optional(list(object({<br>      action    = optional(string)<br>      subnet_id = optional(string)<br>    })))<br>  })</pre> | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether public network access is allowed for the container registry. Defaults to true. | `bool` | `false` | no |
| <a name="input_quarantine_policy_enabled"></a> [quarantine\_policy\_enabled](#input\_quarantine\_policy\_enabled) | Optional) Boolean value that indicates whether quarantine policy is enabled. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_retention_policy"></a> [retention\_policy](#input\_retention\_policy) | n/a | <pre>object({<br>    days    = optional(number)<br>    enabled = optional(bool)<br>  })</pre> | `null` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | (Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) A mapping of tags to assign to the resource. | `map(string)` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | n/a | <pre>object({<br>    create = optional(string)<br>    delete = optional(string)<br>    read   = optional(string)<br>    update = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_trust_policy"></a> [trust\_policy](#input\_trust\_policy) | n/a | <pre>object({<br>    enabled = optional(bool)<br>  })</pre> | `null` | no |
| <a name="input_zone_redundancy_enabled"></a> [zone\_redundancy\_enabled](#input\_zone\_redundancy\_enabled) | (Optional) Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to false. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_output"></a> [output](#output\_output) | n/a |

##### Changelog
###### [0.0.1] - 2023-02-06
- Create module to provisioning Azure DataFactory