##[>] 🤖🤖
variable "gitlab_token" {
  type      = string
  sensitive = true
}

#[why] trailing comment on the sandbox .pub keys (ssh-keygen comment slot); shows in ssh-add -l, agent, signed-commit key display
variable "ssh_key_comment" {
  type = string
}
##[<] 🤖🤖
