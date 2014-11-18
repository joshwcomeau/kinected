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

  before_save :unset_other_primary

  def unset_other_primary
    if primary && self.user
      former_primary = self.user.profile_photos.find_by(primary: true)
      former_primary.update(primary: false) if former_primary
    end
  end
end
