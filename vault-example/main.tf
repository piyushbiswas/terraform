data "vault_generic_secret" "creds" {
  path = "secret/project1"
}


output "name" {
  value = data.vault_generic_secret.creds.data["password"]
  sensitive = false
}
