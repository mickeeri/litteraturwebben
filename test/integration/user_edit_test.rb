require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:testexample)
	end

	test "unsuccessful edit" do
		# Using test helper method to log in.
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), user: { name: "", email: "mail@invalid", password: "pass", password_confirmation: "word" }
		assert_template 'users/edit'
	end

	test "successful edit with friendly forwarding" do
		get edit_user_path(@user)
		# Using test helper method to log in.
		log_in_as(@user)
		# Checks if user is redirected to edit page.
		assert_redirected_to edit_user_path(@user)
		name = "Foo Bar"
		email = "foo@bar.com"
		patch user_path(@user), user: { name: name, email: email, password: "", password_confirmation: "" }
		assert_not flash.empty?
		assert_redirected_to @user
		# Reload users values from database to see if they are updated.
		@user.reload
		assert_equal @user.name, name
		assert_equal @user.email, email
	end
end
