##[>] 🤖🤖
resource "google_secret_manager_secret" "gitlab_token" {
  secret_id = "sandbox-gitlab-group-token"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "gitlab_token" {
  secret      = google_secret_manager_secret.gitlab_token.id
  secret_data = var.gitlab_token
}

resource "google_secret_manager_secret_iam_member" "gitlab_token_reader" {
  secret_id = google_secret_manager_secret.gitlab_token.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.restricted.email}"
}

resource "google_secret_manager_secret" "ssh_private_key" {
  secret_id = "sandbox-ssh-private-key"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "ssh_private_key" {
  secret      = google_secret_manager_secret.ssh_private_key.id
  secret_data = tls_private_key.sandbox.private_key_openssh
}

resource "google_secret_manager_secret_iam_member" "ssh_private_key_reader" {
  secret_id = google_secret_manager_secret.ssh_private_key.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.restricted.email}"
}
##[<] 🤖🤖
