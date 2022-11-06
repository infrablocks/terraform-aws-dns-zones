data "aws_vpc" "default" {
  default = true
}

module "dns_zones" {
  source = "../../"

  domain_name = var.domain_name
  private_domain_name = var.private_domain_name

  private_zone_vpc_id = data.aws_vpc.default.id
  private_zone_vpc_region = var.region
}
