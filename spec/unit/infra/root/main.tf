data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}

module "dns_zones" {
  source = "../../../.."

  domain_name = var.domain_name
  private_domain_name = var.private_domain_name

  private_zone_vpc_id = data.terraform_remote_state.prerequisites.outputs.default_vpc_id
  private_zone_vpc_region = data.terraform_remote_state.prerequisites.outputs.default_vpc_region
}
