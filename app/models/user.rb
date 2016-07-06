class User < ActiveRecord::Base
  # Accessible attributes. To make tokens available without storing in database.
  attr_accessor :remember_token, :reset_token
  before_save :downcase_email

  # VALIDATION
  validates :name, presence: true, length: { maximum: 50 }

  # Email validation
  # Sets user's email to lower-case version of current value.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  # Password validation
  has_secure_password
  # Allow blank so user don't have to change password on update.
  # has_secure_password still makes sure password is not blank on user sign-up.
  validates :password, length: { minimum: 6 }, allow_blank: true

  # Method to create bcrypt password digest via has_secure_password.
  def self.digest(string)
    # Uses minimum cost paramater in test and normal (high)
    # cost parameter in production.
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    # Create password digest. Snippet from secure password source code.
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns random token for remember_digest.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Compares given token with digest using is_password? method.
  # Match returns true.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    # Return false immediately if remeber_digest is nil.
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # For user to be able to log out, this method undoes user.remeber
  # by updating the remember digest with nil.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Reset digest.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Password reset e-mail.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if password has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
