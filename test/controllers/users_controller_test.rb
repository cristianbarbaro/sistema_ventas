require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index if admin sign in" do
    get admin_users_url
    assert_response :success
  end

  test "should redirect in get index if not admin sign in" do
    sign_in users(:user1)
    get admin_users_url
    assert_response :redirect
  end


end
