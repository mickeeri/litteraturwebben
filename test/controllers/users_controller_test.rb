require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:testexample)
    @other_user = users(:user2)
  end

  # Test that prevents accidental exposure of edit methods
  # to unauthorized users.
  test '2.1.1 should redirect edit when not logged in' do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test '2.1.2 should redirect update when not logged in' do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test '2.1.3 should redirect edit when logged in as wrong user' do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test '2.1.4 should redirect update when logged in as wrong user' do
    log_in_as(@other_user)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  # Destroy tests

  test '2.1.5 should redirect destroy when not logged in' do
    # Makes sure user doesn't change.
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end

  test '2.1.6 should redirect destroy when logged in as non-admin' do
    log_in_as(@user)
    # Makes sure user doesn't change.
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end
end
