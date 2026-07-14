##[>] 🤖🤖
resource "gitlab_group_access_token" "sandbox" {
  group        = var.konradodwrot_group_id
  name         = "sandbox-rw-nodelete"
  scopes       = ["api", "write_repository", "read_repository"]
  access_level = "developer"
  expires_at   = var.token_expires_at
}
##[<] 🤖🤖
