#EC2 instance template
resource "aws_instance" "instance" {
    ami                    = "${var.ami_baseos}"
    availability_zone      = "${var.availability_zone}"
    instance_type          = "${var.instance_type}"
    key_name               = "${var.masterkey}"
    vpc_security_group_ids = ["${var.sgs}"]
    subnet_id              = "${var.subnet}"
    iam_instance_profile   = "${var.profile}"
    private_ip             = "${var.private_ip}"
    ebs_optimized          = "${var.ebs_optimized}"
    root_block_device      = {
                                volume_size = "${var.size}"
                                volume_type = "${var.voltype}"
                             }
    tags {
            Name  = "${var.instance_name}"
            group = "${var.group_name}"
         }

}

resource "aws_eip" "eip" {
    instance = "${aws_instance.instance.id}"
    vpc      = true
    count    = "${var.count}"
}
