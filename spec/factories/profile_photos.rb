# == Schema Information
#
# Table name: profile_photos
#
#  id            :integer          not null, primary key
#  photo_object  :string(255)
#  primary_photo :boolean          default(TRUE)
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#  caption       :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile_photo do
    photo_object { File.open("/users/Shared/sample#{Random.rand(1..18)}.jpg") }
    caption { Faker::Lorem.sentence }
  end
end
