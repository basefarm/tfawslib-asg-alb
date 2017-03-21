resource "aws_autoscaling_group" "asg" {
  name                      = "${var.nameprefix}"
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = "${var.desired_capacity}"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.asg.name}"
  termination_policies      = [ "OldestLaunchConfiguration", "OldestInstance" ]
  tag { "key" = "CostCenter"
        "value" = "${var.costcenter}"
        propagate_at_launch = true }
  tag { "key" = "Name"
        "value" = "${var.nameprefix}-asg${count.index}"
        propagate_at_launch = true }
  lifecycle { create_before_destroy = true }
  vpc_zone_identifier = ["${var.subnets}"]
  target_group_arns = [ "${var.target_groups}" ]
}
resource "aws_launch_configuration" "asg" {
  name_prefix = "${var.nameprefix}-"
  image_id = "${var.image_id == "" ? data.aws_ami.bf_rhel7_ebs.image_id : var.image_id}"
  instance_type = "${var.instance_type}"
  key_name = "${var.sshkey}"
  lifecycle { create_before_destroy = true }
  user_data = "${var.user_data}"
  security_groups = [ "${var.target_security_groups}" ]
}