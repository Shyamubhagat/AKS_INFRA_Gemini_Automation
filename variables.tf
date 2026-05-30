variable "resource_groups" {
  type = map(object({
    location = string
    tags     = optional(map(string), {})
  }))
}

variable "registries" {
  type = map(object({
    resource_group_key = string
    location           = optional(string)
    sku                = optional(string)
    admin_enabled      = optional(bool)
    tags               = optional(map(string))
    georeplications = optional(list(object({
      location                = string
      zone_redundancy_enabled = optional(bool)
      tags                    = optional(map(string))
    })))
  }))
  default = {}
}

variable "aks_clusters" {
  type = map(object({
    resource_group_key = string
    location           = optional(string)
    dns_prefix         = string
    kubernetes_version = optional(string)
    tags               = optional(map(string))
    default_node_pool = object({
      name                = string
      node_count          = optional(number)
      vm_size             = optional(string)
      enable_auto_scaling = optional(bool)
      min_count           = optional(number)
      max_count           = optional(number)
    })
    extra_node_pools = optional(map(object({
      vm_size    = string
      node_count = optional(number)
    })))
  }))
  default = {}
}
