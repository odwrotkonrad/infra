##[>] 🤖🤖
#[why] P521 matches fn-ssh-generate-keys (ecdsa-sha2-nistp521); private key stays sensitive, only the Secrets Manager version consumes it
resource "tls_private_key" "sandbox" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P521"
}
##[<] 🤖🤖
