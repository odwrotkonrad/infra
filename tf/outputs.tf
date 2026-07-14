##[>] 🤖🤖
#[why] base64 JSON key: `terraform output -raw restricted_sa_key | base64 -d | op item edit ...` (Part 3), one-time, run by you
output "restricted_sa_key" {
  value     = google_service_account_key.restricted.private_key
  sensitive = true
}

output "restricted_sa_email" {
  value = google_service_account.restricted.email
}

output "gitlab_token_secret" {
  value = google_secret_manager_secret.gitlab_token.secret_id
}

output "ssh_private_key_secret" {
  value = google_secret_manager_secret.ssh_private_key.secret_id
}
##[<] 🤖🤖
