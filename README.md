Terraform AWS DNS Zones
=======================

A Terraform module for building a public/private DNS pair in AWS.

This consists of:
* A public DNS zone
* A private DNS zone

## Usage

To use the module, include something like the following in your terraform configuration:

```hcl-terraform
module "dns-zones" {
  source = "git@github.com:infrablocks/terraform-aws-dns-zones.git//src"

  domain_name = "jimmythompson.co.uk"
  private_domain_name = "jimmythompson.net"

  # Default VPC
  private_zone_vpc_id = "vpc-6e12c307"
  private_zone_vpc_region = "us-east-2"
}
```

Executing `terraform get` will fetch the module.

### Inputs

| Name                    | Description                                       | Default | Required |
|-------------------------|---------------------------------------------------|:-------:|:--------:|
| domain_name             | The domain name for the public DNS zone           | -       | yes      |
| private_domain_name     | The domain name for the private DNS zone          | -       | yes      |
| private_zone_vpc_id     | The VPC to attach the private DNS zone to         | -       | yes      |
| private_zone_vpc_region | The region for the VPC                            | -       | yes      |

### Outputs

| Name                         | Description                        |
|------------------------------|------------------------------------|
| public_zone_id               | The ID of the created public zone  |
| private_zone_id              | The ID of the created private zone |
