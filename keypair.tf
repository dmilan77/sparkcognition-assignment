resource "tls_private_key" "this" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "${var.generalname}-key"
  public_key = tls_private_key.this.public_key_openssh
}


# output key_private_key_pem_out {
#   value       = tls_private_key.private_key_pem
#   sensitive   = false
#   description = "description"
#   depends_on  = []
# }
