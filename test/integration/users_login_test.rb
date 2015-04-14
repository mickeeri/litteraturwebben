require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:testexample)
	end

	test "login with valid information" do
		get login_path
		post login_path, session: { email: @user.email, password: 'password' }
		# Check the right redirect target.
		assert_redirected_to @user
		follow_redirect!
		assert_template 'users/show'
		# Visits target page and verify that login link disappears.
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", logout_path
		assert_select "a[href=?]", user_path(@user)
	end


	test "login with invalid information" do
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
end
