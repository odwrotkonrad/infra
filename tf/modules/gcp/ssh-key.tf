##[>] 🤖🤖
#[why] P521 matches fn-ssh-generate-keys (ecdsa-sha2-nistp521); private key stays sensitive, only the Secrets Manager version consumes it
resource "tls_private_key" "sandbox" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P521"
}

#[why] distinct signing key, mirrors the host's separate id_access/id_signing layout; pushed to gitlab as a signing key via REST out-of-band (the provider's gitlab_user_sshkey has no usage_type=signing)
resource "tls_private_key" "sandbox_signing" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P521"
}
##[<] 🤖🤖
