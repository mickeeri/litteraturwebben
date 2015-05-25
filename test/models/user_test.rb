require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: "Example User", email: "user@example.com",
						password: "lösenord", password_confirmation: "lösenord")
	end

	# Test 1.1.1.
	# Test if user is valid.
	test "should be valid" do
		assert @user.valid?
	end

	# Test 1.1.2.
	# Should not be valid if name is blank.
	test "name should be present" do
		@user.name = "     "
		assert_not @user.valid?
	end

	# Test 1.1.3. Should not be valid if email is blank.
	test "email should be present" do
		@user.email = "		"
		assert_not @user.valid?
	end

	# Test 1.1.4
	test "email validation should accept valid addresses" do
		valid_addresses = %w[user@exempel.se USER@example.com A_US-ER@e.mail.org first.last@foo.jp kalle+lisa@baz.cn]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, "#{valid_address.inspect} should be valid"
		end
	end

	# Test 1.1.5.
	test "email validation should reject invalid addresses" do
		invalid_addresses = %w[user@example,com user_at_mail.org user.name@example. user@e_mail.com user@e+post.com user@mail..com]
		invalid_addresses.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
		end
	end

	# Test 1.1.6.
	# Test to avoid duplicate email addresses
	test "email addresses should be unique" do
		# dup duplicates user with same attributes.
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

	# Test 1.1.7.
	# Test of password validation
	test "password should have a minimum length of 6 characters" do
		@user.password = @user.password_confirmation = "a" * 5
		assert_not @user.valid?
	end

	# TEST 1.1.8
	test "authenticated? should return false for a user with nil digest" do
		assert_not @user.authenticated?(:remember, '')
	end

	# TEST 1.1.9
	test "name should not be too long" do
		@user.name = "a" * 51
		assert_not @user.valid?
	end

	# TEST 1.1.10
	test "email shuld not be too long" do
		@user.email = "a" * 244 + "@example.com"
		assert_not @user.valid?
	end

	# TEST 1.1.11
	# Test uses reload method to see if value from database is equal to lower-case value.
	test "emails should be saved as lower-case" do
		mixed_case_email = "EpoST@exEMeL.CoM"
		@user.email = mixed_case_email
		@user.save
		assert_equal mixed_case_email.downcase, @user.reload.email
	end
end
