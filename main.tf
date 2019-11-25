resource "aws_route53_zone" "public_zone" {
  name = var.domain_name
}

resource "aws_route53_zone" "private_zone" {
  name = var.private_domain_name

  vpc {
    vpc_id = var.private_zone_vpc_id
    vpc_region = var.private_zone_vpc_region
  }
}
