##[>] 🤖🤖
output "ssh_public_key" {
  value = tls_private_key.sandbox.public_key_openssh
}

output "sa_key" {
  value     = google_service_account_key.restricted.private_key
  sensitive = true
}

output "sa_email" {
  value = google_service_account.restricted.email
}

output "gitlab_token_secret" {
  value = google_secret_manager_secret.gitlab_token.secret_id
}

output "ssh_private_key_secret" {
  value = google_secret_manager_secret.ssh_private_key.secret_id
}
##[<] 🤖🤖
