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
#  concierge_id           :integer
#

class User < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :ethnicities, dependent: :destroy
  has_many :profile_photos, dependent: :destroy

  # PERMISSIONS. The relationships that dictate who can chat with who.
  # Self referential association (http://railscasts.com/episodes/163-self-referential-association?view=asciicast)
  
  # Who I want to message
  has_many :permissions, dependent: :destroy
  has_many :target_users, through: :permissions, dependent: :destroy

  # Who wants to message me
  has_many :inverse_permissions, class_name: 'Permission', foreign_key: 'target_user_id'
  has_many :inverse_target_users, through: :inverse_permissions, source: :user

  # MESSAGES. Similar to permissions.
  has_many :messages_sent, class_name: 'Message', foreign_key: 'user_id', dependent: :destroy
  has_many :recipients, through: :messages_sent, dependent: :destroy
  
  has_many :messages_received, class_name: 'Message', foreign_key: 'recipient_id'
  has_many :senders, through: :messages_received, source: :user

  # FAVORITES. Again, similar to permissions & messages.
  has_many :favorites, dependent: :destroy
  has_many :target_users, through: :favorites, dependent: :destroy

  has_many :inverse_favorites, class_name: 'Favorite', foreign_key: 'target_user_id'
  has_many :inverse_target_users, through: :inverse_favorites, source: :user
  

  has_many :answers, dependent: :destroy
  has_many :questions, through: :answers

  has_many :activities

  # Association between daters and concierges
  has_many :managed_daters, -> { where(role: 0) }, foreign_key: 'concierge_id', class_name: "User"
  belongs_to :concierge, -> { where(role: 1) }, foreign_key: 'concierge_id', class_name: "User"



  accepts_nested_attributes_for :answers


  enum role:          [ :dater, :concierge, :admin ]
  enum sex:           [ :female, :male ]
  enum status:        [ :trial, :active, :deleted ]

  scope :daters,              -> { where(role: 0) }
  scope :matched_daters,      -> (sex) { where(role: 0, sex: sex) }
  scope :paying,              -> { where(status: 1) }
  scope :free_trial,          -> { where(status: 0) }
  scope :concierges,          -> { where(role: 1) }
  scope :between_ages,        -> (min_age, max_age) { where("birthdate between ? and ?", max_age.years.ago, min_age.years.ago) }
  scope :recently_logged_in,  -> { order("last_sign_in_at DESC") }
  scope :with_photos,         -> { joins(:profile_photos).where("profile_photos.id IS NOT NULL").uniq }

  def get_blocked_users
    User.joins(:inverse_permissions)
      .where("permissions.status  = :status", status: 0)
      .where("permissions.user_id = :user", user: id) + 
    User.joins(:permissions)
      .where("permissions.status  = :status", status: 0)
      .where("permissions.target_user_id = :user", user: id)
  end



  scope :not_blocked, -> (user) do 
    includes(:permissions).where("permissions.recipient_id = :user AND permissions.status = :status")
  end


  # geocoded_by :last_sign_in_ip
  # after_validation :geocode
  
  # Can I chat with a given user?
  def can_chat_with(user)

  end

  def age
    if self.birthdate
      now = Time.now.utc.to_date
      now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
    end
  end  

  # Will return a hash containing two relations
  def messages
    Message
      .where("messages.user_id = :user OR messages.recipient_id = :user", user: id)
      .where.not("messages.recipient_id = :user AND messages.status = :status", user: id, status: 0)
      .where.not("messages.recipient_id = :user AND messages.status = :status", user: id, status: 4)
      .includes(:permissions).order("permissions.created_at DESC")
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


  def match_query
    User.matched_daters(get_desired_sex).with_photos.recently_logged_in - self.with_history
  end

  def get_list_of_matches
    format_user_list_for_angular(self.match_query)
  end

  def get_first_match
    users = self.match_query
    if users.any?
      users.first.get_full_match_data(self)
    end
  end

  def can_view_profile?(u)
    # The criteria are as follows. They must be:
    # - opposite sex
    # - a dater (not a concierge or admin)
    # - not blocked or having blocked me
    # - have at least 1 profile photo

    sex != u.sex &&
    u.role == "dater" &&
    u.permissions.find_by("status = :status AND (user_id = :user OR target_user_id = :user)", status: 0, user: id).nil? &&
    u.profile_photos.any?
  end


  def get_contacts
    User.joins(:inverse_permissions)
      .where("permissions.status  = :status", status: 1)
      .where("permissions.user_id = :user", user: id) &
    User.joins(:permissions)
      .where("permissions.status  = :status", status: 1)
      .where("permissions.target_user_id = :user", user: id)
  end

  def get_blocked_users
    User.joins(:inverse_permissions)
      .where("permissions.status  = :status", status: 0)
      .where("permissions.user_id = :user", user: id) + 
    User.joins(:permissions)
      .where("permissions.status  = :status", status: 0)
      .where("permissions.target_user_id = :user", user: id)
  end

  def with_history
    User.joins(:permissions).where("permissions.target_user_id = :user", user: id) + 
    User.joins(:inverse_permissions).where("permissions.user_id = :user", user: id)
  end

  def get_full_match_data(current_user)
    user = self.attributes
    user[:profile_photos]         = self.profile_photos.order("primary_photo DESC")

    user[:birthdate]    = time_in_ms(self.birthdate)
    user[:joined_num]   = time_in_ms(self.created_at)
    user[:joined_ago]   = time_ago_in_words(self.created_at) + " ago"  
    user[:updated_num]  = time_in_ms(self.updated_at)
    user[:updated_ago]  = time_ago_in_words(self.updated_at)
    user[:ethnicities]  = self.ethnicities  
    user[:eth_string]   = self.ethnicities.pluck(:name).join("\n")

    user[:sex]          = self.sex.capitalize

    if self.height
      user_height         = Unit("#{self.height} cm")
      user[:height_cm]    = user_height.to_s(:m)
      user[:height_ft]    = user_height.to_s(:ft)
    end

    if self.last_sign_in_at
      user[:last_seen_num]  = time_in_ms(self.last_sign_in_at)
      user[:last_seen_ago]  = time_ago_in_words(self.last_sign_in_at) + " ago"
    end

    user[:answers_attributes] = []
    self.answers.includes(:question).each do |a|
      user[:answers_attributes] << {body: a.body, id: a.id, question_body: a.question.body}
    end
    user[:answers_attributes].shuffle!

    user[:unanswered_questions] = Question.where.not(body: self.questions.map(&:body)) 

    user[:favorited] = Favorite.find_by(user_id: current_user.id, target_user_id: id)

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
    sex == 'male' ? 0 : 1 # We only need to grab members of the opposite sex.
  end

  def time_in_ms(time)
    unless time.nil?
      # We need a time object, not a date object. Birthday is stored as a Date
      time = time.to_time if time.is_a? Date
      time.to_i * 1000
    end
  end

end

