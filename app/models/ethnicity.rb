# == Schema Information
#
# Table name: ethnicities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Ethnicity < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :name, presence: true
end
