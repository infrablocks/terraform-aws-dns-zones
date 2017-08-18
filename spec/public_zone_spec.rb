require 'spec_helper'

describe 'Public zone' do
  let(:domain_name) { vars.domain_name }

  subject { route53_hosted_zone("#{domain_name}.") }

  it { should exist }
end
