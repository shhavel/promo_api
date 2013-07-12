class OptIn < ActiveRecord::Base
  attr_accessible :email, :mobile, :first_name, :last_name, :permission_type, :channel, :company_name
  validates :permission_type, inclusion: %w(one-time permanent)
  validates :channel, inclusion: %w(sms email sms+email)
  validates :email, presence: true, uniqueness: { scope: :company_name }
  validates :company_name, presence: true
end
