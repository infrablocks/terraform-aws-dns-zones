# frozen_string_literal: true

require 'spec_helper'

describe 'DNS zone' do
  let(:domain_name) do
    var(role: :root, name: 'domain_name')
  end
  let(:private_domain_name) do
    var(role: :root, name: 'private_domain_name')
  end
  let(:default_vpc_id) do
    output(role: :prerequisites, name: 'default_vpc_id')
  end
  let(:default_vpc_region) do
    output(role: :prerequisites, name: 'default_vpc_region')
  end

  describe 'by default' do
    before(:context) do
      @plan = plan(role: :root)
    end

    it 'creates a public hosted zone' do
      expect(@plan)
        .to(include_resource_creation(
          type: 'aws_route53_zone',
          name: 'public_zone'
        ).once)
    end

    it 'uses the provided domain name as the name of the public hosted zone' do
      expect(@plan)
        .to(include_resource_creation(
          type: 'aws_route53_zone', name: 'public_zone'
        ).with_attribute_value(:name, domain_name))
    end

    it 'outputs the public zone ID' do
      expect(@plan)
        .to(include_output_creation(name: 'public_zone_id'))
    end

    it 'outputs the public zone name servers' do
      expect(@plan)
        .to(include_output_creation(name: 'public_zone_name_servers'))
    end

    it 'creates a private hosted zone' do
      expect(@plan)
        .to(include_resource_creation(
          type: 'aws_route53_zone',
          name: 'private_zone'
        ).once)
    end

    it 'uses the provided private domain name as the name of the ' \
       'private hosted zone' do
      expect(@plan)
        .to(include_resource_creation(
          type: 'aws_route53_zone', name: 'private_zone'
        ).with_attribute_value(:name, private_domain_name))
    end

    it 'uses the provided VPC ID for the private hosted zone' do
      expect(@plan)
        .to(include_resource_creation(
          type: 'aws_route53_zone', name: 'private_zone'
        )
              .with_attribute_value(
                [:vpc, 0, :vpc_id], default_vpc_id
              ))
    end

    it 'uses the provided VPC region for the private hosted zone' do
      expect(@plan)
        .to(include_resource_creation(
          type: 'aws_route53_zone', name: 'private_zone'
        )
              .with_attribute_value(
                [:vpc, 0, :vpc_region], default_vpc_region
              ))
    end

    it 'outputs the private zone ID' do
      expect(@plan)
        .to(include_output_creation(name: 'private_zone_id'))
    end

    it 'outputs the private zone name servers' do
      expect(@plan)
        .to(include_output_creation(name: 'private_zone_name_servers'))
    end
  end

  # it { is_expected.to exist }
  #
  # it 'outputs the zone id' do
  #   expect(private_zone.id)
  #     .to(include(output(role: :root, name: 'private_zone_id')))
  # end
  #
  # it 'outputs the name servers' do
  #   expected_name_servers =
  #     output(role: :root, name: 'private_zone_name_servers')
  #       .join("\n")
  #
  #   expect(private_zone)
  #     .to(have_record_set(private_zone.name)
  #               .ns(expected_name_servers))
  # end
end
