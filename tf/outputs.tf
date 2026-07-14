##[>] 🤖🤖
#[why] base64 JSON key: `terraform output -raw restricted_sa_key | base64 -d | op item edit ...` (Part 3), one-time, run by you
output "restricted_sa_key" {
  value     = module.gcp.sa_key
  sensitive = true
}

output "restricted_sa_email" {
  value = module.gcp.sa_email
}

output "gitlab_token_secret" {
  value = module.gcp.gitlab_token_secret
}

output "ssh_private_key_secret" {
  value = module.gcp.ssh_private_key_secret
}
##[<] 🤖🤖
