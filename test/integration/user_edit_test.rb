require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:testexample)
	end

	test "3.2.1 unsuccessful edit" do
		# Using test helper method to log in.
		log_in_as(@user)
		# Get of edit form.
		get edit_user_path(@user)
		assert_template 'users/edit'
		# Fills in incorrect data.
		patch user_path(@user), user: { name: "", email: "mail@invalid", password: "pass", password_confirmation: "word" }
		# Verifies that user is still on edit form.
		assert_template 'users/edit'
	end

	test "3.2.2 successful edit with friendly forwarding" do
		get edit_user_path(@user)
		# Using test helper method to log in.
		log_in_as(@user)
		# Checks if user is redirected to edit page.
		assert_redirected_to @user
		name = "Mikael Eriksson"
		email = "mikael@mail.com"
		patch user_path(@user), user: { name: name, email: email, password: "", password_confirmation: "" }
		assert_not flash.empty?
		assert_redirected_to @user
		# Reload users values from database to see if they are updated.
		@user.reload
		assert_equal @user.name, name
		assert_equal @user.email, email
	end
end
