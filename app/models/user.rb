class User < ActiveRecord::Base
  rolify
  after_create :assign_default_role
  before_create :assign_default_state
  STATE_ACTIVE = 'active'
  STATE_INACTIVE = 'inactive'
  STATE_REMOVED = 'removed'
  STATE_QUEUED = 'queued'
  has_many :articles
  validates :firstname, presence: true, length: {minimum:3, maximum: 50}
  validates :lastname, presence: true, length: {minimum:3, maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {minimum:3, maximum: 200},
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive:false }
  validates :username, presence: true, length: {minimum:3}, uniqueness: { case_sensitive:false }
  validates :password, presence: true, confirmation: true, length: {minimum:3, maximum: 50}, on: :create
  has_secure_password
  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
  def assign_default_state
    self.state = STATE_QUEUED if self.state.blank?
  end
end
