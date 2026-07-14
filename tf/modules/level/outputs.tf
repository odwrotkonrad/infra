##[>] 🤖🤖
output "group_ids" {
  value = { for k, v in gitlab_group.this : k => v.id }
}
##[<] 🤖🤖
