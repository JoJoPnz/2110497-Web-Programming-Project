require "test_helper"

class ProfileTest < ActionDispatch::IntegrationTest
  # setup do
  #   sign_in_as users(:buyer1)
  # end

  # test "should show information" do 
  #   get profile_url
  #   assert_response :success
  # end

  # test "should edit password with matching password" do
  #   post edit_password_url(new_password:'123456', confirm_password:'123456')
  #   assert_redirected_to profile_url
  #   assert_equal 'password has been changed', flash[:success]
  # end

  # test "should not be able to edit password with not matching password" do
  #   post edit_password_url(new_password:'123456', confirm_password:'wrong password')
  #   assert_redirected_to edit_password_url
  #   assert_equal 'password and confirm password are not match', flash[:error]
  end

  test "should not be able to access my_market page if not login" do
    get logout_url
    get profile_url
    assert_redirected_to login_url
    assert_equal 'you must be login first', flash[:notice]
  end
end
