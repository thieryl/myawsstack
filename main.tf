provider "aws" {
  shared_credentials_file = "/home/thieryl/.aws/tlo-aws"
  region                  = "default"
  profile                 = "default"
}

variable "project_path" {
  type    = "string"
  default = "vancluever/advent_demo"
}

// The IP space for the VPC.
variable "vpc_network_address" {
  type    = "string"
  default = "10.0.0.0/24"
}

// The IP space for the subnets within the VPC.
variable "public_subnet_addresses" {
  type    = "list"
  default = ["10.0.0.0/25", "10.0.0.128/25"]
}

// vpc creates the VPC that will get created for our project.
module "vpc" {
  source                  = "./modules/aws_vpc"
  vpc_network_address     = "${var.vpc_network_address}"
  public_subnet_addresses = ["${var.public_subnet_addresses}"]
  project_path            = "${var.project_path}"
}

module "alb" {
  source              = "./modules/aws_alb"
  listener_subnet_ids = ["${module.vpc.public_subnet_ids}"]
  project_path        = "your/project"
}

module "autoscaling_group" {
  source             = "./modules/aws_asg"
  subnet_ids         = ["${module.vpc.public_subnet_ids}"]
  image_filter_value = "test_image"
  alb_listener_arn   = "${module.alb.alb_listener_arn}"
  project_path       = "your/project"
}
