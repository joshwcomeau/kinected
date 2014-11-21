# == Schema Information
#
# Table name: profile_photos
#
#  id            :integer          not null, primary key
#  photo_object  :string(255)
#  primary_photo :boolean          default(TRUE)
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#  caption       :string(255)
#

require 'rails_helper'

RSpec.describe ProfilePhoto, :type => :model do
  before(:all) do
    @user = create(:user)
    @new_photo = ProfilePhoto.create(photo_object: File.open("/users/Shared/sample1.jpg"), user_id: @user.id)
  end

  it "sets the uploaded photo to 'primary'" do
    expect(@new_photo.reload.primary_photo).to eq(true)
  end

  it "revokes primary status from old photos upon new upload" do
    @even_newer_photo = ProfilePhoto.create(photo_object: File.open("/users/Shared/sample2.jpg"), user_id: @user.id)
    expect(@even_newer_photo.primary_photo).to eq(true)
    expect(@new_photo.reload.primary_photo).to eq(false)
  end
end
