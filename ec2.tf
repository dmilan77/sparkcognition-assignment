# locals {
#   multiple_instances = {
#     one = {
#       instance_type     = "t3a.nano"
#       availability_zone = element(module.vpc.azs, 0)
#       subnet_id         = element(module.vpc.public_subnets, 0)
#       root_block_device = [
#         {
#           encrypted   = false
#           volume_type = "gp2"
#           volume_size = 8
#         }
#       ]
#     }
#     two = {
#       instance_type     = "t3a.micro"
#       availability_zone = element(module.vpc.azs, 1)
#       subnet_id         = element(module.vpc.public_subnets, 1)
#       root_block_device = [
#         {
#           encrypted   = false
#           volume_type = "gp2"
#           volume_size = 50
#         }
#       ]
#     }
#   }
# }

# module "ec2_multiple" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "~> 3.0"
#   for_each = local.multiple_instances

#   name = "${local.name}-multi-${each.key}"

#   ami                    = data.aws_ami.amazon_linux.id
#   instance_type          = each.value.instance_type
#   availability_zone      = each.value.availability_zone
#   subnet_id              = each.value.subnet_id
#   vpc_security_group_ids = [module.security_group.security_group_id]

#   enable_volume_tags = false
#   root_block_device  = lookup(each.value, "root_block_device", [])

#   tags = local.tags
# }
