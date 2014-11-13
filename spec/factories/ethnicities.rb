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
FactoryGirl.define do
  factory :ethnicity do
    name         { %w( African/Black Asian Latino/Latina White European Indian ).sample }
  end
end
