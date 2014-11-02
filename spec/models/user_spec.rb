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
#  role                   :integer          default(0)
#  status                 :integer          default(0)
#  latitude               :float
#  longitude              :float
#  self_summary           :text
#  height                 :integer
#  income                 :integer
#  num_of_kids            :integer
#  body_type              :integer
#  smoking                :integer
#  drinking               :integer
#  religion               :integer
#  education              :integer
#  work_industry          :integer
#  wants_kids             :integer
#  relationship_status    :integer
#

require 'rails_helper'

RSpec.describe User, :type => :model do
  it "gets saved with a valid email and password" do
    user = build(:user)
    expect(user.save).to eq(true)
  end

  it "doesn't get saved when the password is too short" do
    user = build(:user, password: '123')
    expect(user.save).to eq(false)
  end

  it "doesn't get saved when the email isn't unique" do
    user1 = create(:user, email: 'john@doe.com')
    user2 = build(:user, email: 'john@doe.com')

    expect(user2.save).to eq(false)
  end

  it "has a default role of 'dater', and can be set to 'concierge' or 'admin'" do
    dater = create(:user)
    expect(dater.role).to eq("dater")

    concierge = create(:user, role: 1)
    expect(concierge.concierge?).to eq(true)

    admin = create(:user)
    admin.admin!
    expect(admin.role).to eq("admin")
  end

  it "can save associated ethnicities" do
    user = build(:user)
    user.ethnicities << Ethnicity.create(name: 'Asian')
    user.ethnicities << Ethnicity.create(name: 'White')

    expect(user.save).to eq(true)
    expect(user.ethnicities.count).to eq(2)
  end
end
