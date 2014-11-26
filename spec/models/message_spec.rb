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
  before(:all) do
    @msg = create(:message)
  end

  it "contains a valid sender and receiver" do
    expect(@msg.user).to be_a(User)
    expect(@msg.recipient).to be_a(User)
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

  # Callback called after_create
  describe ".set_sender_permission" do
    before(:all) do
      @me   = create(:user)
      @them = create(:user)
      @msg  = create(:message, user_id: @me.id, recipient_id: @them.id)
    end 

    subject { @msg.permissions.first }

    it { is_expected.to be_a Permission }
    it { is_expected.to be_persisted }

    it "sets the user to the sender and the target_user to the recipient" do
      expect(subject.user).to eq(@me)
      expect(subject.target_user).to eq(@them)
    end

    it "sets the permission to 'allowed'" do
      expect(subject.status).to eq("allowed")
    end
  end

  # Callback called after_save
  describe ".set_recipient_permission" do
    context "when accepting the message" do
      before(:all) do 
        @me   = create(:user)
        @them = create(:user)
        @msg  = create(:message, user_id: @me.id, recipient_id: @them.id)
        @msg.update(status: 3) 
      end
      
      it "creates a second permission" do
        expect(@msg.permissions.count).to eq(2)
      end

      it "has the right user and target_user" do
        expect(@msg.permissions.find_by(user_id: @them.id, target_user_id: @me.id)).not_to be_nil
      end

      it "has the right status" do
        expect(@msg.permissions.find_by(user_id: @them.id, target_user_id: @me.id).allowed?).to eq(true)
      end
    end
  end
end
