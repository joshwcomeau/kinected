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

  LIMIT = 1     # number of messages a user may send per day

  belongs_to :user
  belongs_to :recipient, class_name: 'User'

  has_many :permissions # Specifically, it can have up to 2. One for the sender, one for the receiver.

  validates :user_id, presence: true
  validates :recipient_id, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  after_create :set_sender_permission

  after_save :set_recipient_permission

  enum status: [ :queued, :sent, :read, :accepted, :rejected ]
  # 'Queued'  means the man has submitted the message, but it's in the woman's queue.
  # 'Sent'    means it's made it to the woman's inbox, but she hasn't seen it yet.
  # 'Read'    means she's seen it, but hasn't responded.



  def has_been_accepted?
    self.permissions.count == 2 && self.permissions.first.status == 'allowed' && self.permissions.last.status == 'allowed'
  end
  

  private

  # When a message gets sent, we're taking it as implied that the sender is willing to chat with the recipient.
  # We create a Permission object after_create to testify to this.
  def set_sender_permission
    self.permissions << Permission.create({
      user_id:        user_id,
      target_user_id: recipient_id,
      status:         1
    })
  end

  # If the recipient accepts the message, we create a positive permission.
  def set_recipient_permission
    if self.accepted? && self.permissions.find_by(user_id: recipient_id, target_user_id: user_id).nil?
      self.permissions.create(user_id: recipient_id, target_user_id: user_id, status: 1)
    end
  end
end