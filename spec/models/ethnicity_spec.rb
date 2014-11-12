# == Schema Information
#
# Table name: ethnicities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Ethnicity, :type => :model do
  before(:each) do
    @user = create(:user)
    @ethnicity1 = create(:ethnicity)
    @ethnicity2 = create(:ethnicity)    
  end

  it "has_and_belongs_to_many users" do
    expect(@user.ethnicities.count).to eq(2)
  end 
end
