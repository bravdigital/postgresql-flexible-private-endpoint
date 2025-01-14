#####################
## DNS - Resources ##
#####################

# Reference to Private DNS Zone for PostgreSQL
# data "azurerm_private_dns_zone" "postgres_dns_zone" {
#   name                = "privatelink.postgres.database.azure.com"
#   resource_group_name = var.private_dns_resource_group
# }

# Create the Resource Group for DNS Zone
resource "azurerm_resource_group" "postgres_dns_zone" {
  name     = "bravdigital-dns-rg"
  location = var.location
}

# Create Private DNS Zone for PostgreSQL
resource "azurerm_private_dns_zone" "postgres_dns_zone" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.postgres_dns_zone.name
}
