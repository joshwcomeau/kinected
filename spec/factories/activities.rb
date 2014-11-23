# == Schema Information
#
# Table name: activities
#
#  id             :integer          not null, primary key
#  action         :string(255)
#  seen           :boolean
#  trackable_id   :integer
#  trackable_type :string(255)
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    action "create"
  end
end
