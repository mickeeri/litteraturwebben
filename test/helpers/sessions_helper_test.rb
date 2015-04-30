require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

	def setup
		# Define a user using the fixture.
		@user = users(:testexample)
		# Call remember method to remeber given user.
		remember(@user)
	end

	test "current_user returns right user when session is nil" do
		# Verify that current_user is equal to the given user.
		assert_equal @user, current_user
		assert is_logged_in?
	end

	# Checks that current user is nil if the user's remember digest doesn't match the remeber token,
	# also testing authenticated? expression.
	test "current_user returns nil when remember digest is wrong" do
		@user.update_attribute(:remember_digest, User.digest(User.new_token))
		assert_nil current_user
	end
end