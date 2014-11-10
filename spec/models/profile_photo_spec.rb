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
end
