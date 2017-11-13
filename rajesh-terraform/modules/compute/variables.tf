variable "availability_zone" {}
variable "instance_name" {}
#variable "instance_role" {}
variable "ami_baseos" {}
variable "instance_type" {}
variable "masterkey" {}
variable "sgs" { type="list" }
variable "profile" {}
variable "subnet" {}
variable "size" {}
variable "voltype" {}
variable "private_ip" {}
variable "count" {}
variable "ebs_optimized" { default=false }
variable "group_name" {}
