class User < ActiveRecord::Base
	# Accessible attribute. To make token available without storing in database.
	attr_accessor :remember_token

	# Username validation
	validates :name, presence: true, length: { maximum: 50 }

	# Email validation
	# Sets user's email to lower-case version of current value.
	before_save { email.downcase! }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
				format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	# Password validation
	has_secure_password
	# Allow blank so user don't have to change password on update. has_secure_password still makes sure password is not blank on user sign-up.
	validates :password, length: { minimum: 6 }, allow_blank: true

	# Method to create bcrypt password digest via has_secure_password.
	def User.digest(string)
	    # Uses minimum cost paramter in test and normal (high) cost parameter in production.
	    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
	    # Create password digest. Snippet from secure password source code.
	    BCrypt::Password.create(string, cost: cost)
	end

	# Returns random token for remember_digest.
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# Remembers a user in the database for use in persistent sessions.
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Compares given token with digest using is_password? method. Match returns true.
	def authenticated?(remember_token)
		# Return false immediately if remeber digest is nil.
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# For user to be able to log out, this method undoes user.remeber by updating the remember digest with nil.
	def forget
		update_attribute(:remember_digest, nil)
	end
end


