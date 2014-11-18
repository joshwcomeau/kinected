# == Schema Information
#
# Table name: profile_photos
#
#  id           :integer          not null, primary key
#  photo_object :string(255)
#  primary      :boolean          default(TRUE)
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile_photo do
    photo_object { File.open("/users/Shared/sample#{Random.rand(1..18)}.jpg") }
    caption { Faker::Lorem.paragraph }
  end
end
