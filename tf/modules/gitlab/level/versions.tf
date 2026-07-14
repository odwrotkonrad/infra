##[>] 🤖🤖
terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 18.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}
##[<] 🤖🤖
