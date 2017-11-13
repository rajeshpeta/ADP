provider "aws" { }

module "vpc" {
  source                  = "../modules/vpc"
  vpc_cidr                = "${var.vpc_cidr}"
  env                     = "${var.env}"
  }

resource "aws_security_group" "ec2_security_group" {
  vpc_id = "${aws_vpc.ec2_vpc.id}"

  name = "ec2_ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}


# Create SSH key pair
resource "aws_key_pair" "master" {
  key_name   = "ec2_key_name"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCx0PZMUM+ML5K3SW1mMHiB3L/v3Xh91sAiHFlt7Qf4++w999RMANP5GIbLRyYqc1KqJlreJQsv1ChuLn059gNdtz4l551jw56lAotuFUIOZ3LhTlw1XlX/bQTYGJAfxzgqs3BMPVBG3eZVtqY3gk2cI+w+SvAy0WYGVrZPuPJfmPL5gKU+ys8IvhLUqXKfUXWx8tu77Ni71/WjRfPqNHyIr6sPt6K03LOF03Qm9EQWHolf1wKesg+pUs1i0HEr0DC34WYWJUiDG1f/flkPvKqQa57rmIX2gMZicWEzyInPqZc8+dXDCoO4khjPzb0U1CImAiUYphhESIOOZ1rhVc+X rajesh@mypc"
}

module "ec2" {
   source             = "../modules/compute"
   instance_type      = "t2.micro"
   instance_name      = "${var.env}-test"
   availability_zone  = "${var.availability_zone}"
   ami_baseos         = "${var.ami}"
   masterkey          = "${aws_key_pair.master.id}"
   sgs                = ["${aws_security_group.ec2_security_group.id}"]
   subnet             = "${module.vpc.public_ids}"
   private_ip         = ""
   profile            = ""
   size               = "8"
   voltype            = "standard"
   count              = "1"
   group_name         = ""
}