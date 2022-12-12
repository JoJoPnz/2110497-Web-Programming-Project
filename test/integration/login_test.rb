require "test_helper"

class LoginTest < ActionDispatch::IntegrationTest
  test "should be able to login with correct password" do
    get login_url
    @user = users(:admin1)
    post main_create_url(email: @user.email , password:"password")
    assert_redirected_to main_url
  end

  test "test should not be able to login with wrong password" do
    get login_url
    @user = users(:admin1)
    post main_create_url(email: @user.email , password:"wrong password")
    assert_redirected_to login_url
    assert_equal "wrong username or password", flash[:error]
  end
end
