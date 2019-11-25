module "dns_zones" {
  source = "../../../../"

  domain_name = var.domain_name
  private_domain_name = var.private_domain_name

  private_zone_vpc_id = var.private_zone_vpc_id
  private_zone_vpc_region = var.private_zone_vpc_region
}
