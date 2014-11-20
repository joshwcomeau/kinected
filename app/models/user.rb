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
#  body_type              :string(255)
#  smoking                :string(255)
#  drinking               :string(255)
#  religion               :string(255)
#  education              :string(255)
#  work_industry          :string(255)
#  wants_kids             :string(255)
#  relationship_status    :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  display_name           :string(255)
#  city                   :string(255)
#  state                  :string(255)
#

class User < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :ethnicities
  has_many :profile_photos, dependent: :destroy

  # PERMISSIONS. The relationships that dictate who can chat with who.
  # Self referential association (http://railscasts.com/episodes/163-self-referential-association?view=asciicast)
  
  # Who I want to message
  has_many :permissions  
  has_many :target_users, through: :permissions

  # Who wants to message me
  has_many :inverse_permissions, class_name: 'Permission', foreign_key: 'target_user_id'
  has_many :inverse_target_users, through: :inverse_permissions, source: :user

  # MESSAGES. Similar to permissions.
  has_many :messages_sent, class_name: 'Message', foreign_key: 'user_id'
  has_many :recipients, through: :messages_sent
  
  has_many :messages_received, class_name: 'Message', foreign_key: 'recipient_id'
  has_many :senders, through: :messages_received, source: :user

  # FAVORITES. Again, similar to permissions & messages.
  has_many :favorites
  has_many :target_users, through: :favorites

  has_many :inverse_favorites, class_name: 'Favorite', foreign_key: 'target_user_id'
  has_many :inverse_target_users, through: :inverse_favorites, source: :user
  


  enum role:          [ :dater, :concierge, :admin ]
  enum sex:           [ :male, :female ]

  scope :daters,              -> { where(role: 0) }
  scope :matched_daters,      -> (sex) { where(role: 0, sex: sex) }
  scope :between_ages,        -> (min_age, max_age) { where("birthdate between ? and ?", max_age.years.ago, min_age.years.ago) }
  scope :recently_logged_in,  -> { order("last_sign_in_at DESC") }

  # geocoded_by :last_sign_in_ip
  # after_validation :geocode
  
  # Can I chat with a given user?
  def can_chat_with(user)

  end

  # Will return a hash containing two relations (hopefully)
  def messages
    Message.where("user_id = :user or recipient_id = :user", user: id)
  end

  def primary_profile_photo
    self.profile_photos.find_by(primary_photo: true).try(:photo_object) || ProfilePhoto.new.photo_object
  end

  def primary_profile_photo_thumb
    self.profile_photos.find_by(primary_photo: true).try(:photo_object).try(:thumb) || ProfilePhoto.new.photo_object
  end

  def primary_profile_photo_blurred_thumb
    self.profile_photos.find_by(primary_photo: true).try(:photo_object).try(:blurred_thumb) || ProfilePhoto.new.photo_object
  end



  # --> OUTDATED <--
  # def find_next_user(num=0, options={})
  #   desired_sex = sex == 'male' ? 1 : 0
  #   min_age = options[:min_age] || 18
  #   max_age = options[:max_age] || 99
  #   valid_users = User.matched_daters(desired_sex).between_ages(min_age, max_age).recently_logged_in
  #   valid_users[num]
  # end

  # We're returning a JSON object that contains the minimal data needed to sort and retrieve matches.
  # We need their id, age, last login time, created_at time, etc. 



  def get_list_of_matches
    users = User.matched_daters(get_desired_sex).recently_logged_in
    format_user_list_for_angular(users)
  end

  def get_first_match
    users = User.matched_daters(get_desired_sex).recently_logged_in
    users.first.get_full_match_data
  end


  def get_full_match_data
    user = self.attributes
    user[:profile_photos]         = self.profile_photos.order("primary_photo DESC")

    user[:birthdate]    = time_in_ms(self.birthdate)
    user[:joined_num]   = time_in_ms(self.created_at)
    user[:joined_ago]   = time_ago_in_words(self.created_at)    
    user[:updated_num]  = time_in_ms(self.updated_at)
    user[:updated_ago]  = time_ago_in_words(self.updated_at)
    user[:ethnicities]  = self.ethnicities  
    user[:eth_string]   = self.ethnicities.pluck(:name).join("\n")

    user[:sex]          = self.sex.capitalize

    if self.height
      user_height = Unit("#{self.height} cm")
      user[:height_cm]    = user_height.to_s(:m)
      user[:height_ft]    = user_height.to_s(:ft)
    end

    if self.last_sign_in_at
      user[:last_seen_num]  = time_in_ms(self.last_sign_in_at)
      user[:last_seen_ago]  = time_ago_in_words(self.last_sign_in_at) + " ago"
    end

    user
  end


  private

  def format_user_list_for_angular(users)
    users.map do |u| 
      {
        id:             u.id,
        joined:         time_in_ms(u.created_at),
        last_seen:      time_in_ms(u.last_sign_in_at)      }
    end
  end
  
  def get_desired_sex
    sex == 'male' ? 1 : 0 # We only need to grab members of the opposite sex.
  end

  def time_in_ms(time)
    unless time.nil?
      # We need a time object, not a date object. Birthday is stored as a Date
      time = time.to_time if time.is_a? Date
      time.to_i * 1000
    end
  end

end
