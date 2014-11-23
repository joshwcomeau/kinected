# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  birthdate              :date
#  country                :string(255)
#  postal_code            :string(255)
#  sex                    :integer          default(0)
#  status                 :integer          default(0)
#  role                   :integer
#  latitude               :float
#  longitude              :float
#  self_summary           :text
#  height                 :integer
#  income                 :integer
#  num_of_kids            :integer
#  body_type              :string(255)
#  smoking                :string(255)
#  drinking               :string(255)
#  religion               :string(255)
#  education              :string(255)
#  work_industry          :string(255)
#  wants_kids             :string(255)
#  relationship_status    :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  display_name           :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  concierge_id           :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email         { Faker::Internet.free_email }
    password      "12345678"
    birthdate     { Date.today - Random.rand(18..50).years }
    country       "Canada"
    city          "Toronto"
    state         "Ontario"
    postal_code   "M5V 2R2"
    height        { Random.rand(120..200) }
    sex           { Random.rand(0..1) } # male
    role          0 # dater
    self_summary  { Faker::Lorem.paragraph }
    num_of_kids   { Random.rand(0..3) }
    body_type     { Random.rand(0..4) }
    smoking       { Random.rand(0..1) }
    drinking      { Random.rand(0..1) }
    religion      { Random.rand(0..10) }
    education     { Random.rand(0..4) }
    work_industry { Random.rand(0..20) }
    wants_kids    { Random.rand(0..1) }
    first_name    { Faker::Name.first_name }
    last_name     { Faker::Name.last_name }
    display_name  { Faker::Internet.user_name }

    after(:create) do |user|
      # Attach a profile photo
      create_list(:profile_photo, 3, user_id: user.id)
    end

    factory :user_with_messages do
      ignore do
        recipient { create(:user) }
      end

      after(:create) do |user, evaluator|
        create(:message, user: user, recipient: evaluator.recipient)
      end
    end
  end

  factory :concierge, class: User do
    email         { Faker::Internet.free_email }
    password      "12345678"
    birthdate     Date.today - 21.years
    country       "Canada"
    postal_code   "M5V 2R2"
    height        188
    sex           0 # male
    role          1 # concierge
  end
end
