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
