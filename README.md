Terraform AWS DNS Zones
=======================

[![CircleCI](https://circleci.com/gh/infrablocks/terraform-aws-dns-zones.svg?style=svg)](https://circleci.com/gh/infrablocks/terraform-aws-dns-zones)

A Terraform module for building a public/private DNS pair in AWS.

This consists of:
* A public DNS zone
* A private DNS zone

![Diagram of infrastructure managed by this module](https://raw.githubusercontent.com/infrablocks/terraform-aws-dns-zones/master/docs/architecture.png)

Usage
-----

To use the module, include something like the following in your terraform 
configuration:

```hcl-terraform
module "dns-zones" {
  source = "infrablocks/dns-zones/aws"

  domain_name = "jimmythompson.co.uk"
  private_domain_name = "jimmythompson.net"

  # Default VPC
  private_zone_vpc_id = "vpc-6e12c307"
  private_zone_vpc_region = "us-east-2"
}
```


### Inputs

| Name                    | Description                               | Default | Required |
|-------------------------|-------------------------------------------|:-------:|:--------:|
| domain_name             | The domain name for the public DNS zone   | -       | yes      |
| private_domain_name     | The domain name for the private DNS zone  | -       | yes      |
| private_zone_vpc_id     | The VPC to attach the private DNS zone to | -       | yes      |
| private_zone_vpc_region | The region for the VPC                    | -       | yes      |


### Outputs

| Name                      | Description                                  |
|---------------------------|----------------------------------------------|
| public_zone_id            | The ID of the created public zone            |
| public_zone_name_servers  | The name servers of the created public zone  |
| private_zone_id           | The ID of the created private zone           |
| private_zone_name_servers | The name servers of the created private zone |


Development
-----------

### Machine Requirements

In order for the build to run correctly, a few tools will need to be installed on your
development machine:

* Ruby (2.3.1)
* Bundler
* git
* git-crypt
* gnupg
* direnv

#### Mac OS X Setup

Installing the required tools is best managed by [homebrew](http://brew.sh).

To install homebrew:

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Then, to install the required tools:

```
# ruby
brew install rbenv
brew install ruby-build
echo 'eval "$(rbenv init - bash)"' >> ~/.bash_profile
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
eval "$(rbenv init -)"
rbenv install 2.3.1
rbenv rehash
rbenv local 2.3.1
gem install bundler

# git, git-crypt, gnupg
brew install git
brew install git-crypt
brew install gnupg

# direnv
brew install direnv
echo "$(direnv hook bash)" >> ~/.bash_profile
echo "$(direnv hook zsh)" >> ~/.zshrc
eval "$(direnv hook $SHELL)"

direnv allow <repository-directory>
```

### Running the build

To provision module infrastructure, run tests and then destroy that infrastructure,
execute:

```bash
./go
```

To provision the module prerequisites:

```bash
./go deployment:prerequisites:provision[<deployment_identifier>]
```

To provision the module contents:

```bash
./go deployment:harness:provision[<deployment_identifier>]
```

To destroy the module contents:

```bash
./go deployment:harness:destroy[<deployment_identifier>]
```

To destroy the module prerequisites:

```bash
./go deployment:prerequisites:destroy[<deployment_identifier>]
```


### Common Tasks

To generate an SSH key pair:

```
ssh-keygen -t rsa -b 4096 -C integration-test@example.com -N '' -f config/secrets/keys/bastion/ssh
```

Contributing
------------

Bug reports and pull requests are welcome on GitHub at https://github.com/infrablocks/terraform-aws-dns-zones. 
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to 
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


License
-------

The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
