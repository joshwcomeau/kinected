# == Schema Information
#
# Table name: favorites
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  target_user_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

require 'rails_helper'

RSpec.describe Favorite, :type => :model do
  describe "association with user" do
    before(:all) do
      @me  = create(:user, sex: 'male')
      @her = create(:user, sex: 'female')
      @fav = create(:favorite, user_id: @me.id, target_user_id: @her.id)
    end

    it "retrieves my favorites with built-in helper methods" do
      expect(@me.favorites.first).to eq(@fav)
    end

    it "retrieves inverse favorites with built-in helper methods" do
      expect(@her.inverse_favorites.first).to eq(@fav)
    end

    it "counts the right number of favorites" do
      expect(@me.favorites.count).to  eq(1)
      expect(@her.favorites.count).to eq(0)
      expect(@me.inverse_favorites.count).to eq(0)
      expect(@her.inverse_favorites.count).to eq(1)
    end
  end 
end
