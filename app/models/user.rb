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
end


