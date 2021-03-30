provider "aws" {
  region = var.region
}

######
# VPC
######
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  name = var.name

  cidr = var.cidr

  azs              = var.azs
  redshift_subnets = var.redshift_subnets
}

###########################
# Security group
###########################
module "sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/redshift"
  version = "~> 3.0"

  name   = var.name
  vpc_id = module.vpc.vpc_id

  # Allow ingress rules to be accessed only within current VPC
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

  # Allow all rules for all protocols
  egress_rules = ["all-all"]
}

###########
# Redshift
###########
module "redshift" {
  source = "../../"

  cluster_identifier      = var.name
  cluster_node_type       = var.node_type
  cluster_number_of_nodes = 1

  cluster_database_name   = var.db_name
  cluster_master_username = var.db_user
  cluster_master_password = var.db_password

  subnets                = module.vpc.redshift_subnets
  vpc_security_group_ids = [module.sg.this_security_group_id]

  # redshift_subnet_group_name = module.vpc.redshift_subnet_group
}
