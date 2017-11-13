output "id" {
     value = "${aws_vpc.main.id}"
}

output "igw" {
     value = "${aws_internet_gateway.igw.id}"
}

output "nat-gw" {
     value = "${aws_nat_gateway.nat-gw.id}"
}

output "public_ids" {
 value = "${aws_subnet.public_subnet.id}"
}