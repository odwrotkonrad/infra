##[>] 🤖🤖
module "l0" {
  source = "./level"

  groups          = var.levels[0].groups
  projects        = var.levels[0].projects
  local_runner_id = var.local_runner_id
  github_owner    = var.github_owner
  github_token    = var.github_token
}

module "l1" {
  source = "./level"

  groups          = var.levels[1].groups
  projects        = var.levels[1].projects
  local_runner_id = var.local_runner_id
  parent_ids      = module.l0.group_ids
  github_owner    = var.github_owner
  github_token    = var.github_token
}

module "l2" {
  source = "./level"

  groups          = var.levels[2].groups
  projects        = var.levels[2].projects
  local_runner_id = var.local_runner_id
  parent_ids      = module.l1.group_ids
  github_owner    = var.github_owner
  github_token    = var.github_token
}

module "l3" {
  source = "./level"

  groups          = var.levels[3].groups
  projects        = var.levels[3].projects
  local_runner_id = var.local_runner_id
  parent_ids      = module.l2.group_ids
  github_owner    = var.github_owner
  github_token    = var.github_token
}
##[<] 🤖🤖
