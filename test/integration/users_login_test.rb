require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	def setup
		# Uses fixture testexample.
		@user = users(:testexample)
	end

	test "3.4.1 login with valid information followed by logout" do
		get login_path
		post login_path, session: { email: @user.email, password: 'password' }
		assert is_logged_in?
		# Check the right redirect target.
		#assert_redirected_to @user
		follow_redirect!
		# assert_template 'users/show'
		# Visits target page and verify that login link disappears.
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", logout_path
		assert_select "a[href=?]", user_path(@user)
		# Log-out - verifies that user is logged out and redirected to root url.
		delete logout_path
		assert_not is_logged_in?
		assert_redirected_to root_url
		# Simulate user logging out in a second browser window.
		delete logout_path
		follow_redirect!
		assert_select "a[href=?]", login_path
		assert_select "a[href=?]", logout_path, count: 0
		assert_select "a[href=?]", user_path(@user), count: 0
	end

	test "3.4.2 login with invalid information" do
		# Visit login path
		get login_path
		# Verify that new sessions form renders.
		assert_template 'sessions/new'
		# Post with invalid params.
		post login_path, session: { email: "", password: "" }
		# Verify that new sessions form gets re-rendered and flash error message appears
		assert_template 'sessions/new'
		assert_not flash.empty?
		# Visits another page and makes sure the error message doesn't appear on new page.
		get root_path
		assert flash.empty?
	end

	# Test if remember me checkbox works accordingly.
	test "3.4.3 login with remembering" do
		# remember_me checkbox checked: value = 1
		log_in_as(@user, remember_me: '1')
		# String key instead of symbol key.
		assert_not_nil cookies['remember_token']
	end

	test "3.4.4 login without remembering" do
		# remember_me checkbox not checked: value = 0
		log_in_as(@user, remember_me: '0')
		# String key instead of symbol key.
		assert_nil cookies['remember_token']
	end
end
