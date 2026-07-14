##[>] 🤖🤖
resource "github_repository" "this" {
  for_each = var.github_repos

  name        = each.key
  description = each.value.description
  topics      = each.value.topics
  visibility  = each.value.visibility
}
##[<] 🤖🤖
