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
    expect(@msg.recipient).to be_a(User)
  end

  it "creates a Permission afterwards" do
    expect(@msg.permissions.count).to eq(1)
  end

  it "permission has the right attributes" do
    permission = @msg.permissions.first
    expect(permission.user_id).to         eq(@msg.user_id)
    expect(permission.target_user_id).to  eq(@msg.recipient_id)
    expect(permission.status).to          eq("allowed")
    expect(permission.message_id).to      eq(@msg.id)
  end

  describe ".has_been_accepted?" do
    before(:all) do
      @me   = create(:user)
      @them = create(:user)
      @msg  = create(:message, user_id: @me.id, recipient_id: @them.id)
    end

    it "returns false when there's no response to the message" do
      expect(@msg.has_been_accepted?).to eq(false)
    end

    it "returns true when the user accepts the message" do
      @msg.permissions.create(user_id: @them.id, target_user_id: @me.id, status: 1)
    end
  end
end
