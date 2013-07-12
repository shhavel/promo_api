require 'spec_helper'

describe OptIn do
  subject do
    described_class.new(email: 'test@gmail.com', permission_type: 'permanent', channel: 'email', company_name: 'milk&cookies')
  end

  it "is valid with valid attributes" do
    should be_valid
  end

  it "is not valid without email" do
    subject.email = ''
    should_not be_valid
  end

  it "is not valid without company_name" do
    subject.company_name = ''
    should_not be_valid
  end

  it "is not valid if permission_type not included in list: one-time, permanent" do
    subject.permission_type = %w(one-time permanent).sample
    should be_valid 
    subject.permission_type = 'two-times'
    should_not be_valid
  end

  it "is not valid if channel not included in list: sms, email, sms+email" do
    subject.channel = %w(sms email sms+email).sample
    should be_valid
    subject.channel = 'phone'
    should_not be_valid
  end

  it "should have unique email company_name scope" do
    described_class.create(email: subject.email, permission_type: 'one-time', channel: 'sms', company_name: subject.company_name)
    should_not be_valid
  end
end
