variable "clusters" {
  type = map(object({
    resource_group_name = string
    location            = string
    dns_prefix          = string
    kubernetes_version  = optional(string)
    tags                = optional(map(string), {})

    default_node_pool = object({
      name                = string
      node_count          = optional(number, 1)
      vm_size             = optional(string, "Standard_DS2_v2")
      type                = optional(string, "VirtualMachineScaleSets")
      zones               = optional(list(string))
      enable_auto_scaling = optional(bool, false)
      min_count           = optional(number)
      max_count           = optional(number)
    })

    identity = optional(object({
      type         = optional(string, "SystemAssigned")
      identity_ids = optional(list(string))
    }), { type = "SystemAssigned" })

    network_profile = optional(object({
      network_plugin    = optional(string, "kubenet")
      load_balancer_sku = optional(string, "standard")
      network_policy    = optional(string)
    }))

    linux_profile = optional(object({
      admin_username = string
      ssh_key = object({
        key_data = string
      })
    }))

    extra_node_pools = optional(map(object({
      vm_size    = string
      node_count = optional(number, 1)
      zones      = optional(list(string))
    })), {})
  }))
  description = "A map of AKS clusters to create."
}
