require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	
	# Verify that clicking submit button is not creating new user if info is invalid. 
	test "invalid signup information" do
		# Visisting signup path.
		get signup_path
		# Compares User.count before and after post.
		assert_no_difference 'User.count' do
			# Issues POST request to users_path.
			post users_path, user: {name: "", email: "user@invalid", password: "abc", password_confirmation: "ab"}
		end
		# Checks if failed submission re-renders the new action. 
		assert_template 'users/new'
		# Checks if error message is displayed. 
		assert_select 'div#error_explanation'
		assert_select 'div.<alert alert-danger>'
	end

	# Verify that clicking submit button is creating new user.
	test "valid signup information" do
		get signup_path
		# Compares User.count after submission. Should have changed by 1. 
		assert_difference 'User.count', 1 do
			# Follows redirect after submission. users/show. 
			post_via_redirect users_path, user: {name: "Exempelanv", email: "user@exempel.se", password: "password", password_confirmation: "password"}
		end
		assert_template 'users/show'
		# Test if success message is displayed. 
		assert_not flash.empty?
	end
end
