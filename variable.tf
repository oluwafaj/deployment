variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resource deployment"
  type        = string
  default     = "East US"
}  

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
  default     = {}
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "virtual_machine_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_DS1_v2"
}
variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
  default     = "azureuser"
}

variable "virtual_machine_count" {
  description = "Number of virtual machines to create"
  type        = number
  default     = 5
}

variable "virtual_machine_name_prefix" {
  description = "Prefix for virtual machine names"
  type        = string
  default     = "vm"
}

variable"storage_account_name" {
  description = "Name of the storage account"
  type        = string
}


