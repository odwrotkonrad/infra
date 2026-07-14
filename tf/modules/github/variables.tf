##[>] 🤖🤖
variable "github_repos" {
  type = map(object({
    description = string
    topics      = set(string)
    visibility  = string
  }))
  default = {}
}
##[<] 🤖🤖
