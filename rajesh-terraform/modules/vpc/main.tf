provider "aws" {}

resource "aws_vpc" "main" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags {
        Name = "${var.env}"
    }
}

# Internet-gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.main.id}"
}


#EIP for Nat attaching
resource "aws_eip" "nat" {
    vpc = true
}

resource "aws_subnet" "public_subnet" {
	vpc_id = "${aws_vpc.ec2_vpc.id}"

	cidr_block = "10.0.0.0/24"
	availability_zone = "ap-south-1a"

	tags {
    Name = "ec2_subnet_public"
  }
}

