require "test_helper"

# main page
class MainTest < ActionDispatch::IntegrationTest
  # Authentication test
  test "should not be able to access main page if not login" do
    get logout_url
    get main_url
    assert_redirected_to login_url
    assert_equal 'you must be login first', flash[:notice]
  end

end
