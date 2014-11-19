# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :favorite do
    user_id         { User.all.sample.try(:id) || 1 }
    target_user_id  { User.all.sample.try(:id) || 2 }
  end
end
