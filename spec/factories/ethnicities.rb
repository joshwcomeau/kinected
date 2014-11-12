# == Schema Information
#
# Table name: ethnicities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl
NAMES = %w( African/Black Asian Latino/Latina White European Indian )
FactoryGirl.define do
  factory :ethnicity do
    name         { NAMES.sample }
  end
end
