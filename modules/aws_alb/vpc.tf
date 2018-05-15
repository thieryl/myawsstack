// module terraform_aws_alb

// primary_subnet is a data source that provides information about the first
// subnet supplied to the module.
data "aws_subnet" "primary_subnet" {
  id = "${var.listener_subnet_ids[0]}"
}

// alb_security_group provides the security group for the ALB.
module "alb_security_group" {
  source       = "../aws_security_group"
  project_path = "${var.project_path}"
  vpc_id       = "${data.aws_subnet.primary_subnet.vpc_id}"
}
