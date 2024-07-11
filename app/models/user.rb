class User < ApplicationRecord
  ATTRIBUTES = %i(name email password password_confirmation).freeze

  validates :name, presence: true, length: {maximum: Settings.max_name_length}
  validates :email, presence: true,
    length: {maximum: Settings.max_email_length},
    format: {with: Regexp.new(Settings.valid_email_regex)},
    uniqueness: true
  validates :password, presence: true,
    length: {minimum: Settings.min_password_length}

  before_save :downcase_email

  has_secure_password

  private
  def downcase_email
    email.downcase!
  end
end
