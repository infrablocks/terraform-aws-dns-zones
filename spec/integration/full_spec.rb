# frozen_string_literal: true

require 'spec_helper'

describe 'full' do
  let(:domain_name) do
    var(role: :full, name: 'domain_name')
  end
  let(:private_domain_name) do
    var(role: :full, name: 'private_domain_name')
  end

  before(:context) do
    apply(role: :full)
  end

  after(:context) do
    destroy(
      role: :full,
      only_if: -> { !ENV['FORCE_DESTROY'].nil? || ENV['SEED'].nil? }
    )
  end

  describe 'public zone' do
    subject(:public_zone) do
      route53_hosted_zone("#{domain_name}.")
    end

    let(:domain_name) do
      var(role: :full, name: 'domain_name')
    end

    it { is_expected.to exist }

    it 'outputs the zone id' do
      expect(public_zone.id)
        .to(include(output(role: :full, name: 'public_zone_id')))
    end

    it 'outputs the name servers' do
      expected_name_servers =
        output(role: :full, name: 'public_zone_name_servers')
        .map { |ns| "#{ns}." }
        .join("\n")

      expect(public_zone)
        .to(have_record_set(public_zone.name)
              .ns(expected_name_servers))
    end
  end

  describe 'private zone' do
    subject(:private_zone) do
      route53_hosted_zone("#{private_domain_name}.")
    end

    let(:private_domain_name) do
      var(role: :full, name: 'private_domain_name')
    end

    it { is_expected.to exist }

    it 'outputs the zone id' do
      expect(private_zone.id)
        .to(include(output(role: :full, name: 'private_zone_id')))
    end

    it 'outputs the name servers' do
      expected_name_servers =
        output(role: :full, name: 'private_zone_name_servers')
        .join("\n")

      expect(private_zone)
        .to(have_record_set(private_zone.name)
              .ns(expected_name_servers))
    end
  end
end
