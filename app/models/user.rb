# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  birthdate              :date
#  country                :string(255)
#  postal_code            :string(255)
#  sex                    :integer          default(0)
#  status                 :integer          default(0)
#  role                   :integer
#  latitude               :float
#  longitude              :float
#  self_summary           :text
#  height                 :integer
#  income                 :integer
#  num_of_kids            :integer
#  body_type              :integer
#  smoking                :integer
#  drinking               :integer
#  religion               :integer
#  education              :integer
#  work_industry          :integer
#  wants_kids             :integer
#  relationship_status    :integer
#  first_name             :string(255)
#  last_name              :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :ethnicities
  
  has_many :profile_photos, dependent: :destroy


  # PERMISSIONS. The relationships that dictate who can chat with who.
  # Self referential association (http://railscasts.com/episodes/163-self-referential-association?view=asciicast)
  
  # Who I want to message
  has_many :permissions  
  has_many :targets, through: :permissions

  # Who wants to message me
  has_many :inverse_permissions, class_name: 'Permission', foreign_key: 'target_user_id'
  has_many :inverse_target_users, through: :inverse_permissions, source: :user

  # MESSAGES. Similar to permissions.
  has_many :messages_sent, foreign_key: 'user_id'
  has_many :recipients, through: :messages_sent
  
  has_many :messages_received, class_name: 'Message', foreign_key: 'recipient_id'
  has_many :senders, through: :messages_received, source: :user


  enum role: [ :dater, :concierge, :admin ]
  enum sex:  [ :male, :female ]

  # Can I chat with a given user?
  def can_chat_with(user)

  end

  # Will return a hash containing two relations (hopefully)
  def messages
    {
      sent:     self.messages_sent,
      received: self.messages_received
    }
  end
end
