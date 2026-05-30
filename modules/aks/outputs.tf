output "aks_ids" {
  value = { for k, v in azurerm_kubernetes_cluster.aks : k => v.id }
}

output "aks_fqdn" {
  value = { for k, v in azurerm_kubernetes_cluster.aks : k => v.fqdn }
}

output "kube_config" {
  value     = { for k, v in azurerm_kubernetes_cluster.aks : k => v.kube_config_raw }
  sensitive = true
}
