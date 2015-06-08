require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: "Example User", email: "user@example.com",
						password: "lösenord", password_confirmation: "lösenord")
	end

	# Test if user is valid.
	test "1.1.1 should be valid" do
		assert @user.valid?
	end

	# Should not be valid if name is blank.
	test "1.1.2 name should be present" do
		@user.name = "     "
		assert_not @user.valid?
	end

	#Should not be valid if email is blank.
	test "1.1.3 email should be present" do
		@user.email = "		"
		assert_not @user.valid?
	end

	test "1.1.4 email validation should accept valid addresses" do
		valid_addresses = %w[user@exempel.se USER@example.com A_US-ER@e.mail.org first.last@foo.jp kalle+lisa@baz.cn]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, "#{valid_address.inspect} should be valid"
		end
	end

	test "1.1.5 email validation should reject invalid addresses" do
		invalid_addresses = %w[user@example,com user_at_mail.org user.name@example. user@e_mail.com user@e+post.com user@mail..com]
		invalid_addresses.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
		end
	end

	# Test to avoid duplicate email addresses
	test "1.1.6 email addresses should be unique" do
		# dup duplicates user with same attributes.
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

	# Test of password validation
	test "1.1.7 password should have a minimum length of 6 characters" do
		@user.password = @user.password_confirmation = "a" * 5
		assert_not @user.valid?
	end

	test "1.1.8 authenticated? should return false for a user with nil digest" do
		assert_not @user.authenticated?(:remember, '')
	end

	test "1.1.9 name should not be too long" do
		@user.name = "a" * 51
		assert_not @user.valid?
	end

	test "1.1.10 email shuld not be too long" do
		@user.email = "a" * 244 + "@example.com"
		assert_not @user.valid?
	end

	# Test uses reload method to see if value from database is equal to lower-case value.
	test "1.1.11 emails should be saved as lower-case" do
		mixed_case_email = "EpoST@exEMeL.CoM"
		@user.email = mixed_case_email
		@user.save
		assert_equal mixed_case_email.downcase, @user.reload.email
	end
end
