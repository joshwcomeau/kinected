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
  before(:all) do
    @user = create(:user)
    @ethnicity1 = create(:ethnicity)
    @ethnicity2 = create(:ethnicity)   

    @user.ethnicities << @ethnicity1
    @user.ethnicities << @ethnicity2 
  end

  it "is valid with a name" do
    expect(@ethnicity1).to be_valid
  end

  it "isn't valid without a name" do
    expect(build(:ethnicity, name: nil)).not_to be_valid
  end

  it "has_and_belongs_to_many users" do
    expect(@user.ethnicities.count).to eq(2)
  end 
end
