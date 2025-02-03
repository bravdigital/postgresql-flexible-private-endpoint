# Create Azure AD Application
resource "azuread_application" "postgres_app" {
  display_name = "postgres-app-${var.environment}"
}

# Create Service Principal
resource "azuread_service_principal" "postgres_sp" {
  client_id = azuread_application.postgres_app.client_id
}

# Create Service Principal Password
resource "azuread_service_principal_password" "postgres_sp_password" {
  service_principal_id = azuread_service_principal.postgres_sp.id
}

# Add at the end of the file
resource "azurerm_role_assignment" "postgres_sp_contributor" {
  scope                = "/subscriptions/${var.azure_subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.postgres_sp.object_id
}

# Outputs
output "postgres_application_client_id" {
  value     = azuread_application.postgres_app.client_id
  sensitive = true
}

output "postgres_service_principal_object_id" {
  value     = azuread_service_principal.postgres_sp.object_id
  sensitive = true
}

output "postgres_service_principal_password" {
  value     = azuread_service_principal_password.postgres_sp_password.value
  sensitive = true
}