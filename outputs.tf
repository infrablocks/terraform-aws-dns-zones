output "public_zone_id" {
  description = "The ID of the created public zone."
  value = "${aws_route53_zone.public_zone.id}"
}

output "public_zone_name_servers" {
  description = "The nameservers of the created public zone."
  value = "${aws_route53_zone.public_zone.name_servers}"
}

output "private_zone_id" {
  description = "The ID of the created private zone."
  value = "${aws_route53_zone.private_zone.id}"
}

output "private_zone_name_servers" {
  description = "The nameservers of the created private zone."
  value = "${aws_route53_zone.private_zone.name_servers}"
}
