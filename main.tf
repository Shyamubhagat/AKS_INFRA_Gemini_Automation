module "resource_groups" {
  source          = "./modules/resource_group"
  resource_groups = var.resource_groups
}

module "acr" {
  source = "./modules/acr"
  registries = {
    for k, v in var.registries : k => merge(v, {
      resource_group_name = module.resource_groups.resource_group_names[v.resource_group_key]
      location            = v.location != null ? v.location : var.resource_groups[v.resource_group_key].location
    })
  }
  depends_on = [module.resource_groups]
}

module "aks" {
  source = "./modules/aks"
  clusters = {
    for k, v in var.aks_clusters : k => merge(v, {
      resource_group_name = module.resource_groups.resource_group_names[v.resource_group_key]
      location            = v.location != null ? v.location : var.resource_groups[v.resource_group_key].location
    })
  }
  depends_on = [module.resource_groups]
}
