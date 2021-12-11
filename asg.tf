module "asg_sg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 4.0"
  # Autoscaling group
  name = "mixed-instance-${local.name}"

  vpc_zone_identifier = module.vpc.public_subnets
  min_size            = 2
  max_size            = 5
  desired_capacity    = 2

  image_id           = data.aws_ami.amazon-linux-2.id
  instance_type      = "t3.micro"
  capacity_rebalance = true
  user_data_base64  = base64encode(local.user_data)


  initial_lifecycle_hooks = [
    {
      name                 = "ExampleStartupLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 60
      lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "hello" = "world" })
    },
    {
      name                 = "ExampleTerminationLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 180
      lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "goodbye" = "world" })
    }
  ]

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  # Launch template
  create_lt              = true
  update_default_version = true

  # Mixed instances
  use_mixed_instances_policy = true
  mixed_instances_policy = {
    instances_distribution = {
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 10
      spot_allocation_strategy                 = "capacity-optimized"
    }

    override = [
      {
        instance_type     = "t3a.nano"
        weighted_capacity = "1"
      },
      {
        instance_type     = "t3a.micro"
        weighted_capacity = "1"
      },
    ]
  }

  tags        = local.tags
  tags_as_map = local.tags_as_map
}