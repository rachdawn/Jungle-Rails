class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip)
    return nil unless user&.authenticate(password)

    user
  end
end
