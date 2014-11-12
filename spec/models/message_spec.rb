# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  recipient_id :integer
#  body         :string(200)
#  status       :integer          default(0)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

RSpec.describe Message, :type => :model do
  before(:each) do
    @msg = create(:message)
  end

  it "contains a valid sender and receiver" do
    expect(@msg.user).to be_a(User)
  end
end
