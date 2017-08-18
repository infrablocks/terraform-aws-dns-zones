require 'spec_helper'

describe 'Private zone' do
  let(:private_domain_name) { vars.private_domain_name }

  subject { route53_hosted_zone("#{private_domain_name}.") }

  it { should exist }
end