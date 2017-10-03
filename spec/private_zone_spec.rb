require 'spec_helper'

describe 'Private zone' do
  let(:private_domain_name) { vars.private_domain_name }

  subject { route53_hosted_zone("#{private_domain_name}.") }

  it { should exist }

  it 'outputs the zone id' do
    expect(subject.id).to(include(output_with_name('private_zone_id')))
  end

  it 'outputs the name servers' do
    expected_name_servers =
        output_with_name('private_zone_name_servers')
            .split(',')
            .join

    puts subject.resource_via_client_record_sets
    puts expected_name_servers

    expect(subject)
        .to(have_record_set(subject.name)
                .ns(expected_name_servers))
  end
end