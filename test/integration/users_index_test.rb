require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
	def setup
		@admin = users(:admin_user)
		@non_admin = users(:pelle)
	end

	test "index as admin including pagination and delete links" do
		log_in_as(@admin)
		get users_path
		assert_template 'users/index'
		assert_select 'div.pagination'
		first_page_of_users = User.paginate(page: 1)
		first_page_of_users.each do |user|
			assert_select 'a[href=?]', user_path(user), text: user.name
			unless user == @admin
				# If user is admin delete link should be present.
				assert_select 'a[href=?]', user_path(user), text: 'Radera användare', method: :delete
			end
		end
		# User count - 1 after delete.
		assert_difference 'User.count', -1 do
			delete user_path(@non_admin)
		end
	end

	# Makes sure there is no delete link if user is non-admin
	test "index as non-admin" do
		log_in_as(@non_admin)
		get users_path
		assert_select 'a', text: 'Radera användare', count: 0
	end

	# Testing users index page pagination.
	test "index including pagination" do
		log_in_as(@non_admin)
		get users_path
		assert_template 'users/index'
		# Checking for a div with class pagination.
		assert_select 'div.pagination'
		# Verifying that the first page of users is present.
		User.paginate(page: 1).each do |user|
			assert_select 'a[href=?]', user_path(user), text: user.name
		end
	end
end
