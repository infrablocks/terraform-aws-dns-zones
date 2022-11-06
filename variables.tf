variable "domain_name" {
  description = "The domain name for the public DNS zone."
}
variable "private_domain_name" {
  description = "The domain name for the private DNS zone."
}

variable "private_zone_vpc_id" {
  description = "The VPC to attach the private DNS zone to."
}
variable "private_zone_vpc_region" {
  description = "The region for the VPC."
}
