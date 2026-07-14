##[>] 🤖🤖
#[why] CI variables for the restricted applier, on the restricted group itself (module.l0 owns it).
#   masked: hidden in job logs. protected: exposed only to protected branches/tags (main).
#   values come from sensitive TF_VAR_* inputs; empty -> group variable created empty + unmasked (GitLab rejects masked empty), populate in the UI. once a real TF_VAR_* value is applied it is masked.
locals {
  restricted_group_id = module.l0.group_ids[var.trees["restricted"].path]
}

resource "gitlab_group_variable" "ci_gitlab_token" {
  group     = local.restricted_group_id
  key       = "TF_GITLAB_TOKEN"
  value     = var.ci_gitlab_token
  masked    = var.ci_gitlab_token != ""
  protected = true
}

#[why] the SA key TF just generated (already base64) feeds its own CI applier var: no manual copy-paste, self-heals on rotation.
resource "gitlab_group_variable" "ci_google_credentials" {
  group     = local.restricted_group_id
  key       = "GOOGLE_CREDENTIALS"
  value     = google_service_account_key.restricted.private_key
  masked    = true
  protected = true
}

resource "gitlab_group_variable" "ci_github_token" {
  group     = local.restricted_group_id
  key       = "GITHUB_TOKEN"
  value     = var.ci_github_token
  masked    = var.ci_github_token != ""
  protected = true
}
##[<] 🤖🤖
