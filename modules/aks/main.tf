resource "azurerm_kubernetes_cluster" "aks" {
  for_each = var.clusters

  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix
  kubernetes_version  = each.value.kubernetes_version
  tags                = each.value.tags

  default_node_pool {
    name                = each.value.default_node_pool.name
    node_count          = each.value.default_node_pool.node_count
    vm_size             = each.value.default_node_pool.vm_size
    type                = each.value.default_node_pool.type
    zones               = each.value.default_node_pool.zones
    enable_auto_scaling = each.value.default_node_pool.enable_auto_scaling
    min_count           = each.value.default_node_pool.min_count
    max_count           = each.value.default_node_pool.max_count
  }

  dynamic "identity" {
    for_each = [each.value.identity]
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "network_profile" {
    for_each = each.value.network_profile != null ? [each.value.network_profile] : []
    content {
      network_plugin    = network_profile.value.network_plugin
      load_balancer_sku = network_profile.value.load_balancer_sku
      network_policy    = network_profile.value.network_policy
    }
  }

  dynamic "linux_profile" {
    for_each = each.value.linux_profile != null ? [each.value.linux_profile] : []
    content {
      admin_username = linux_profile.value.admin_username
      ssh_key {
        key_data = linux_profile.value.ssh_key.key_data
      }
    }
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "extra" {
  for_each = merge([
    for cluster_name, cluster_data in var.clusters : {
      for pool_name, pool_data in cluster_data.extra_node_pools :
      "${cluster_name}-${pool_name}" => merge(pool_data, {
        cluster_id = azurerm_kubernetes_cluster.aks[cluster_name].id
        name       = pool_name
      })
    }
  ]...)

  name                  = each.value.name
  kubernetes_cluster_id = each.value.cluster_id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  zones                 = each.value.zones
}
