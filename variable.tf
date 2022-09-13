variable "rgName" {
    type = string
    description = "resource group name"
}
 
variable "VNET_name1" {
    type = string
    description = "Virtual network name"
}
variable "VNET_name2" {
    type = string
    description = "Virtual network name"
}
variable "rglocation" {
    type = string
    description = "rg Location"
 
}
variable "rglocation2" {
    type = string
    description = "rg2 Location"
 
}
variable "default_tags" {
    type = map(string)
    description = "tags"
}
 
variable "addySpace" {
    type = list(string)
    description = "address space for vnet1"
}
variable "addySpace2" {
    type = list(string)
    description = "address space for vnet2"
}
 
variable "addyPrefixVnet1" {
    type = list(string)
    description = "Vnet1 subnet address"
}
 
variable "addyPrefixVnet2" {
    type = list(string)
    description = "Vnet2 subnet address"
}
variable "vnet1sub" {
    type = string
    description = "vnet 1 name"
}
variable "vnet2sub" {
    type = string
    description = "vnet 2 name"
}
 
variable "rgName2" {
    type = string
    description = "second resource groups name"
}

variable "accounttier" {
    type = string
    description = "Account tier"
  
}

variable "storageName" {
    type = string
    description = "Storage name"
  
}

variable "blobName" {
    type = string
    description = "Blob name"
  
}
