# output "east_scaleset_id" {
#     value = azurerm_subnet.web_tier_east.id
  
# }

# output "central_scaleset_id" {
#     value = azurerm_subnet.web_tier_central.id
  
# }
output "bastionsubnetid" {
    value = azurerm_subnet.bastion_host_east.id
}
output "bastionsubnetid2" {
    value = azurerm_subnet.bastion_host_central.id
}
