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

class ProfilePhoto < ActiveRecord::Base
  belongs_to :user
  mount_uploader :photo_object, ProfilePhotoUploader
end
