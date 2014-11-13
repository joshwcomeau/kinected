# == Schema Information
#
# Table name: permissions
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  target_user_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#  status         :integer
#  message_id     :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :permission do
    status "allowed"
    user
    association :target_user, factory: :user
  end
end
