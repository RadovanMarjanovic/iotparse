class User < ApplicationRecord
  VALID_PASSWORD_REGEX = /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/x

  # for bcript gem
  has_secure_password

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
  validates_format_of :password, with: VALID_PASSWORD_REGEX, message: 'Complexity requirement not met. Please use: 1 uppercase, 1 lowercase, 1 digit and 1 special character',
            if: -> { new_record? || !password.nil? }

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  has_many :activity_logs
end
