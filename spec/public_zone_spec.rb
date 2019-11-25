require 'spec_helper'

describe 'Public zone' do
  let(:domain_name) {vars.domain_name}

  subject {route53_hosted_zone("#{domain_name}.")}

  it {should exist}

  it 'outputs the zone id' do
    expect(subject.id).to(include(output_for(:harness, 'public_zone_id')))
  end

  it 'outputs the name servers' do
    expected_name_servers =
        output_for(:harness, 'public_zone_name_servers', parse: true)
          .map { |ns| "#{ns}."}
          .join("\n")

    expect(subject)
        .to(have_record_set(subject.name)
                .ns(expected_name_servers))
  end
end
