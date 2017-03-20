#ASG-ALB
#variable "" { default="" type = "string" }
variable "costcenter" { type="string" }
variable "nameprefix" { type="string" }
variable "vpc" { type = "string" }
variable "target_security_groups" { type = "list" }
variable "target_groups" { type = "list" }
variable "subnets" { type = "list" }
variable "sshkey" { type="string" }
variable "datadog_apikey" { type="string" }
variable "max_size" { default="2" type = "string" }
variable "min_size" { default="0" type = "string" }
variable "desired_capacity" { default="1" type = "string" }
variable "instance_type" { default="t2.micro" type = "string" }
variable "image_id" { default="" type = "string" }
variable "user_data" { default="" type = "string" }
data "aws_ami" "bf_rhel7_ebs" {
  most_recent = true
  owners = ["054714998694"]
  filter {
    name = "name"
    values = ["bf-rhel-7*"]
  }
}