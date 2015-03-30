require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  # Test expect home and help to be ordinary web pages accessed using GET request.
  test "should get home" do
    get :home
    assert_response :success
    # Looks if there is a title tag with that name.
    assert_select "title", "Hem | Litteraturappen"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Hjälp | Litteraturappen"
  end

  test "should get about" do
  	get :about
  	assert_response :success
  	assert_select "title", "Om | Litteraturappen"
  end

end
