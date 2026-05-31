variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
  
    tags     = optional(map(string), {})
  }))
  description = "A map of resource groups to create."
}
