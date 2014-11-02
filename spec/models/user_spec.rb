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
#

require 'rails_helper'

RSpec.describe User, :type => :model do
  it "gets saved with a valid email and password" do
    user = User.new(email: 'james@dean.com', password: '12345678')
    expect(user.save).to eq(true)
  end

  it "doesn't get saved when the password is too short" do
    user = User.new(email: 'james@dean.com', password: '123')
    expect(user.save).to eq(false)
  end

  it "sends a confirmation email upon successful signup" do
    
  end
end
