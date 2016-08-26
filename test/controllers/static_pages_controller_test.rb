require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  def setup
    @base_title = 'Litteraturwebben'
  end

  # Test 2.2.1
  # Test expect home and help to be ordinary web pages accessed using GET request.
  test 'should get home' do
    get :home
    assert_response :success
    # Looks if there is a title tag with that name.
    assert_select 'title', "Hem | #{@base_title}"
  end

  test 'should get about' do
    get :about
    assert_response :success
    assert_select 'title', "Om | #{@base_title}"
  end
end
