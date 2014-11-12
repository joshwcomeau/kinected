# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  recipient_id :integer
#  body         :string(200)
#  status       :integer          default(0)
#  created_at   :datetime
#  updated_at   :datetime
#

class Message < ActiveRecord::Base

  belongs_to :user
  belongs_to :recipient, class_name: 'User'

  validates :user_id, presence: true
  validates :recipient_id, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  enum status: [ :pending, :sent, :read, :accepted, :rejected ]
  # 'Pending' means the man has submitted the message, but it's in the woman's queue.
  # 'Sent'    means it's made it to the woman's inbox, but she hasn't seen it yet.
  # 'Read'    means she's seen it, but hasn't responded.
end
