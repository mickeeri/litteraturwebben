require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

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
