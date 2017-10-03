output "public_zone_id" {
  value = "${aws_route53_zone.public_zone.id}"
}

output "public_zone_name_servers" {
  value = "${aws_route53_zone.public_zone.name_servers}"
}

output "private_zone_id" {
  value = "${aws_route53_zone.private_zone.id}"
}

output "private_zone_name_servers" {
  value = "${aws_route53_zone.private_zone.name_servers}"
}
