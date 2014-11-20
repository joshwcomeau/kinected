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

class ProfilePhoto < ActiveRecord::Base
  belongs_to :user
  mount_uploader :photo_object, ProfilePhotoUploader

  before_save :unset_other_primary

  def unset_other_primary
    if primary_photo && self.user
      former_primary = self.user.profile_photos.find_by(primary_photo: true)
      former_primary.update(primary_photo: false) if former_primary && former_primary != self
    end
  end
end
