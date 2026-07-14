##[>] 🤖🤖
moved {
  from = gitlab_group_access_token.sandbox
  to   = module.gitlab.gitlab_group_access_token.sandbox
}

moved {
  from = gitlab_group_variable.ci_gitlab_token
  to   = module.gitlab.gitlab_group_variable.ci_gitlab_token
}

moved {
  from = gitlab_group_variable.ci_github_token
  to   = module.gitlab.gitlab_group_variable.ci_github_token
}

moved {
  from = gitlab_user_sshkey.sandbox
  to   = module.gitlab.gitlab_user_sshkey.sandbox
}

moved {
  from = gitlab_user_sshkey.this
  to   = module.gitlab.gitlab_user_sshkey.this
}

moved {
  from = module.l0
  to   = module.gitlab.module.l0
}

moved {
  from = module.l1
  to   = module.gitlab.module.l1
}

moved {
  from = module.l2
  to   = module.gitlab.module.l2
}

moved {
  from = module.l3
  to   = module.gitlab.module.l3
}

moved {
  from = tls_private_key.sandbox
  to   = module.gcp.tls_private_key.sandbox
}

moved {
  from = google_service_account.restricted
  to   = module.gcp.google_service_account.restricted
}

moved {
  from = google_service_account_key.restricted
  to   = module.gcp.google_service_account_key.restricted
}

moved {
  from = google_secret_manager_secret.gitlab_token
  to   = module.gcp.google_secret_manager_secret.gitlab_token
}

moved {
  from = google_secret_manager_secret_version.gitlab_token
  to   = module.gcp.google_secret_manager_secret_version.gitlab_token
}

moved {
  from = google_secret_manager_secret_iam_member.gitlab_token_reader
  to   = module.gcp.google_secret_manager_secret_iam_member.gitlab_token_reader
}

moved {
  from = google_secret_manager_secret.ssh_private_key
  to   = module.gcp.google_secret_manager_secret.ssh_private_key
}

moved {
  from = google_secret_manager_secret_version.ssh_private_key
  to   = module.gcp.google_secret_manager_secret_version.ssh_private_key
}

moved {
  from = google_secret_manager_secret_iam_member.ssh_private_key_reader
  to   = module.gcp.google_secret_manager_secret_iam_member.ssh_private_key_reader
}
##[<] 🤖🤖
