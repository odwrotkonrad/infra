##[>] 🤖🤖
locals {
  #[why] konradodwrot root stays declared but out of the plan until its state is adopted (manage_konradodwrot flips true).
  active_trees = {
    for k, t in var.trees : k => t
    if k != "konradodwrot" || var.manage_konradodwrot
  }

  #[why] per-root l0..l3 pyramids, then merged across roots. keys stay fully path-qualified so konradodwrot/* and restricted/* never collide and every state address is preserved.
  per_root = {
    for rk, tree in local.active_trees : rk => {
      l0_raw = {
        (tree.path) = {
          name        = tree.name
          leaf_path   = tree.path
          path        = tree.path
          description = tree.description
          projects    = tree.projects
          defaults    = tree.defaults
          raw         = tree
        }
      }
    }
  }

  l0_raw = merge([for rk, r in local.per_root : r.l0_raw]...)

  l1_raw = merge([
    for pk, pg in local.l0_raw : {
      for ck, cg in try(pg.raw.groups, {}) :
      "${pg.path}/${cg.path}" => {
        name        = cg.name
        leaf_path   = cg.path
        path        = "${pg.path}/${cg.path}"
        description = cg.description
        parent      = pg.path
        projects    = try(cg.projects, {})
        defaults    = pg.defaults
        raw         = cg
      }
    }
  ]...)

  l2_raw = merge([
    for pk, pg in local.l1_raw : {
      for ck, cg in try(pg.raw.groups, {}) :
      "${pg.path}/${cg.path}" => {
        name        = cg.name
        leaf_path   = cg.path
        path        = "${pg.path}/${cg.path}"
        description = cg.description
        parent      = pg.path
        projects    = try(cg.projects, {})
        defaults    = pg.defaults
        raw         = cg
      }
    }
  ]...)

  l3_raw = merge([
    for pk, pg in local.l2_raw : {
      for ck, cg in try(pg.raw.groups, {}) :
      "${pg.path}/${cg.path}" => {
        name        = cg.name
        leaf_path   = cg.path
        path        = "${pg.path}/${cg.path}"
        description = cg.description
        parent      = pg.path
        projects    = try(cg.projects, {})
        defaults    = pg.defaults
        raw         = cg
      }
    }
  ]...)

  levels = [
    for lvl in [local.l0_raw, local.l1_raw, local.l2_raw, local.l3_raw] : {
      groups = {
        for k, v in lvl : k => {
          name        = v.name
          leaf_path   = v.leaf_path
          description = v.description
          parent      = try(v.parent, null)
        }
      }
      projects = merge([
        for gk, g in lvl : {
          for pk, p in g.projects :
          "${g.path}/${p.path}" => {
            name                = p.name
            path                = p.path
            group               = g.path
            description         = p.description
            allow_force_push    = try(p.allow_force_push, false)
            topics              = try(p.topics, [])
            visibility          = try(p.visibility, "public")
            public_jobs         = try(g.defaults.public_jobs, false)
            protection_level    = try(g.defaults.protection_level, "developer")
            github_mirror       = try(g.defaults.github_mirror, false)
            enable_local_runner = try(p.enable_local_runner, false)
            pages_unique_domain = try(p.pages_unique_domain, null)
          }
        }
      ]...)
    }
  ]

  #[why] mirror the github repos for every project that is push-mirrored (konradodwrot tree only, when active).
  github_repos = merge([
    for lvl in local.levels : {
      for k, p in lvl.projects : p.path => {
        description = p.description
        topics      = p.topics
        visibility  = p.visibility
      } if p.github_mirror
    }
  ]...)
}

resource "github_repository" "this" {
  for_each = local.github_repos

  name        = each.key
  description = each.value.description
  topics      = each.value.topics
  visibility  = each.value.visibility
}

#[why] the provider's gitlab_user_sshkey has no usage_type: only auth keys are manageable here; signing keys go in via the REST api (POST /user/keys usage_type=signing)
resource "gitlab_user_sshkey" "this" {
  for_each = { for k, p in var.user_ssh_keys : k => p if p.usage_type == "auth" }

  title = each.key
  key   = each.value.key
}

module "l0" {
  source = "./modules/level"

  groups          = local.levels[0].groups
  projects        = local.levels[0].projects
  local_runner_id = var.local_runner_id
  github_owner    = var.github_owner
  github_token    = var.github_token

  depends_on = [github_repository.this]
}

module "l1" {
  source = "./modules/level"

  groups          = local.levels[1].groups
  projects        = local.levels[1].projects
  local_runner_id = var.local_runner_id
  parent_ids      = module.l0.group_ids
  github_owner    = var.github_owner
  github_token    = var.github_token

  depends_on = [github_repository.this]
}

module "l2" {
  source = "./modules/level"

  groups          = local.levels[2].groups
  projects        = local.levels[2].projects
  local_runner_id = var.local_runner_id
  parent_ids      = module.l1.group_ids
  github_owner    = var.github_owner
  github_token    = var.github_token

  depends_on = [github_repository.this]
}

module "l3" {
  source = "./modules/level"

  groups          = local.levels[3].groups
  projects        = local.levels[3].projects
  local_runner_id = var.local_runner_id
  parent_ids      = module.l2.group_ids
  github_owner    = var.github_owner
  github_token    = var.github_token

  depends_on = [github_repository.this]
}
##[<] 🤖🤖
