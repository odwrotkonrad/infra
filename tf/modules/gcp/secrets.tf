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

#[why] signing key private half: the sandbox's id_signing, resolved in-pod via gcp://main-493613/sandbox-ssh-signing-key
resource "google_secret_manager_secret" "ssh_signing_key" {
  secret_id = "sandbox-ssh-signing-key"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "ssh_signing_key" {
  secret      = google_secret_manager_secret.ssh_signing_key.id
  secret_data = tls_private_key.sandbox_signing.private_key_openssh
}

resource "google_secret_manager_secret_iam_member" "ssh_signing_key_reader" {
  secret_id = google_secret_manager_secret.ssh_signing_key.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.restricted.email}"
}

#[why] public halves stored too, so the .pub templates resolve in-pod without ssh-keygen -y (GCP holds no derivable public secret otherwise)
resource "google_secret_manager_secret" "ssh_access_key_pub" {
  secret_id = "sandbox-ssh-access-key-pub"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "ssh_access_key_pub" {
  secret      = google_secret_manager_secret.ssh_access_key_pub.id
  secret_data = "${trimspace(tls_private_key.sandbox.public_key_openssh)} ${var.ssh_key_comment}\n"
}

resource "google_secret_manager_secret_iam_member" "ssh_access_key_pub_reader" {
  secret_id = google_secret_manager_secret.ssh_access_key_pub.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.restricted.email}"
}

resource "google_secret_manager_secret" "ssh_signing_key_pub" {
  secret_id = "sandbox-ssh-signing-key-pub"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "ssh_signing_key_pub" {
  secret      = google_secret_manager_secret.ssh_signing_key_pub.id
  secret_data = "${trimspace(tls_private_key.sandbox_signing.public_key_openssh)} ${var.ssh_key_comment}\n"
}

resource "google_secret_manager_secret_iam_member" "ssh_signing_key_pub_reader" {
  secret_id = google_secret_manager_secret.ssh_signing_key_pub.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.restricted.email}"
}
##[<] 🤖🤖
