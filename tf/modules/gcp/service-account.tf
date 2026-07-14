##[>] 🤖🤖
resource "google_service_account" "restricted" {
  account_id   = "sandbox-restricted"
  display_name = "Sandbox restricted (Secrets Manager read)"
}

#[why] long-lived JSON key: the only value stored in op (op://ProgrammaticAccess/sandbox_restricted/sa_key), injected into the pod as ADC
resource "google_service_account_key" "restricted" {
  service_account_id = google_service_account.restricted.name
}
##[<] 🤖🤖
