# == Schema Information
#
# Table name: permissions
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  target_user_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#  status         :integer
#  message_id     :integer
#

class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :target_user, class_name: 'User'
  belongs_to :message

  validates :user_id, presence: true
  validates :target_user_id, presence: true
  validates :status, presence: true

  enum status: [:blocked, :allowed]


  # Returns all messages that have a 'blocked' status attached to them
  def self.blocked_messages
    self.where(status: 0).map(&:messages)
  end
end
