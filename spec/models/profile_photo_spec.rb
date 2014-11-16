# == Schema Information
#
# Table name: profile_photos
#
#  id           :integer          not null, primary key
#  photo_object :string(255)
#  primary      :boolean          default(TRUE)
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

RSpec.describe ProfilePhoto, :type => :model do
  before(:each) do
    @user = create(:user)
    @user.profile_photos << ProfilePhoto.new(photo_object: File.open("/users/Shared/sample1.jpg"))
    @first_photo = @user.profile_photos.first
  end

  it "sets the uploaded photo to 'primary'" do
    expect(@first_photo.primary).to eq(true)
  end

  it "revokes primary status from old photos upon new upload" do
    @user.profile_photos << ProfilePhoto.new(photo_object: File.open("/users/Shared/sample2.jpg"))
    @second_photo = @user.profile_photos.second
    expect(@second_photo.primary).to eq(true)
    expect(@first_photo.reload.primary).to eq(false)
  end
end
