class ProfilePhoto < ActiveRecord::Base
  belongs_to :user
  mount_uploader :photo_object, ProfilePhotoUploader
end
