require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
	def setup
		ActionMailer::Base.deliveries.clear
		@user = users(:test_user)
	end

	test "password resets" do
		# Get of the password reset page.
		get new_password_reset_path
		assert_template 'password_resets/new'
		# Post of invalid email.
		post password_resets_path, password_reset: { email: ""}
		# Should display error message and reload passwords-reset-page.
		assert_not flash.empty?
		assert_template 'password_resets/new'
		# Valid email.
		post password_resets_path, password_reset: { email: @user.email }
		# ???
		assert_not_equal @user.reset_digest, @user.reload.reset_digest
		# Verifies that number of deliveries is one.
		assert_equal 1, ActionMailer::Base.deliveries.size
		# Display success message and redirect to home-page
		assert_not flash.empty?
		assert_redirected_to root_url
		#Password reset form
		user = assigns(:user)
		# Wrong email
		get edit_password_reset_path(user.reset_token, email: "")
		assert_redirected_to root_url
		# # Inactive user (har ingen sådan funktionalitet)
		# user.toggle!(:activated)
		# get edit_password_reset_path(user.reset_token, email: user.email)
		# assert_redirected_to root_url
		# user.toggle!(:activated)

		# Right email, wrong token
		get edit_password_reset_path('wrong token', email: user.email)
		assert_redirected_to root_url
		# Right email, right token
		get edit_password_reset_path(user.reset_token, email: user.email)
		assert_template 'password_resets/edit'
		# Checks if there is an hidden-input-tag.
		assert_select "input[name=email][type=hidden][value=?]", user.email
		# Invalid password & confirmation
		patch password_reset_path(user.reset_token),
			email: user.email,
			user: { password: "adadaasda", password_confirmation: "ojodjsf"}
		assert_select 'div#error_explanation'
		# Blank password
		patch password_reset_path(user.reset_token),
			email: user.email,
			user: { password: "", password_confirmation: "tralala" }
		assert_not flash.empty?
		assert_template 'password_resets/edit'
		# Valid password & confirmation
		patch password_reset_path(user.reset_token),
			email: user.email,
			user: { password: "lösenord", password_confirmation: "lösenord"}
		assert is_logged_in?
		assert_not flash.empty?
		assert_redirected_to user
	end
end
