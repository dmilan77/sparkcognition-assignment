module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.generalname}-vpc"
  cidr = "17.1.0.0/25"

  azs              = ["${local.region}a", "${local.region}b"]
  public_subnets  = ["17.1.0.0/26", "17.1.0.64/26"]
  # private_subnets  = ["17.1.0.0/26", "17.1.0.64/26"]

  # enable_nat_gateway = true
  # enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }

  # private_subnet_tags = {
  #   Tier = "Private"
  # }
  public_subnet_tags = {
    Tier = "Public"
  }
}