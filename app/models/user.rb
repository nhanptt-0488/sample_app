class User < ApplicationRecord
  ATTRIBUTES = %i(name email password password_confirmation).freeze

  validates :name, presence: true, length: {maximum: Settings.max_name_length}
  validates :email, presence: true,
    length: {maximum: Settings.max_email_length},
    format: {with: Regexp.new(Settings.valid_email_regex)},
    uniqueness: true
  validates :password, presence: true,
    length: {minimum: Settings.min_password_length},
    allow_nil: true

  before_save :downcase_email

  has_secure_password

  attr_accessor :remember_token

  private
  def downcase_email
    email.downcase!
  end

  def remember
    self.remember_token = User.new_token
    updated_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def foget
    updated_column :remember_digest, nil
  end

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
