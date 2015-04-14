class User < ActiveRecord::Base
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
	validates :password, length: { minimum: 6 }

	# Method to create bcrypt password digest via has_secure_password.
	def User.digest(string)
	    # Uses minimum cost paramter in test and normal (high) cost parameter in production. 
	    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
	    # Create password digest. Snippet from secure password source code.
	    BCrypt::Password.create(string, cost: cost)	
	end
end


