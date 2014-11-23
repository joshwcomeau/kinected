# == Schema Information
#
# Table name: activities
#
#  id             :integer          not null, primary key
#  action         :string(255)
#  seen           :boolean
#  trackable_id   :integer
#  trackable_type :string(255)
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#

require 'rails_helper'

RSpec.describe Activity, :type => :model do
  describe "association" do
    before(:all) do
      @user1     = create(:user, sex: 'male')
      @user2     = create(:user, sex: 'female')
      @msg       = create(:message, user_id: @user1.id, recipient_id: @user2.id)
      @activity  = Activity.create(action: 'create', trackable: @msg, user: @user2)
    end

    it "gets created and persisted simply by passing in an action and trackable object" do
      expect(@activity).to be_persisted
    end

    it "stores the right data" do
      expect(@activity.trackable_type).to eq("Message")
      expect(@activity.trackable_id).to eq(@msg.id)
    end      

    it "can be fetched through the recipient user" do
      expect(@user2.activities).to include(@activity)
    end

    it "doesn't get attached to the creating user" do
      expect(@user1.activities).not_to include(@activity)
    end
  end
end
