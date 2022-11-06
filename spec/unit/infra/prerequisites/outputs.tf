output "default_vpc_id" {
  value = data.aws_vpc.default.id
}

output "default_vpc_region" {
  value = var.region
}
