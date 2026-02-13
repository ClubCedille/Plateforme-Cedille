# Create an OAuth2 Provider

data "authentik_flow" "default-authorization-flow" {
  slug = "default-provider-authorization-explicit-consent"
}

data "authentik_flow" "default-invalidation-flow" {
  slug = "default-provider-invalidation-flow"
}

resource "authentik_provider_oauth2" "name" {
  name      = "outline-${var.nom_club}"
  client_id = "outline-${var.nom_club}"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  invalidation_flow = data.authentik_flow.default-invalidation-flow.id
}

resource "authentik_application" "name" {
  name              = "outlne-${var.nom_club}"
  slug              = "toutlne-${var.nom_club}"
  protocol_provider = authentik_provider_oauth2.name.id
}

output "outline_client_id" {
  value = authentik_provider_oauth2.name.client_id
}

output "outline_client_secret" {
  value     = authentik_provider_oauth2.name.client_secret
  sensitive = true
}
