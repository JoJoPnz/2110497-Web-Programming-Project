require "test_helper"

class ItemScaffoldTest < ActionDispatch::IntegrationTest
  test "should allow only admin to access item scaffold" do
    sign_in_as users(:buyer1)
    get items_url
    assert_redirected_to main_url
    assert_equal 'you must be admin to access this page', flash[:notice]

    get logout_url
    sign_in_as users(:seller1)
    get items_url
    assert_redirected_to main_url
    assert_equal 'you must be admin to access this page', flash[:notice]

    get logout_url
    sign_in_as users(:admin1)
    get items_url
    assert_response:success
  end

  test "should not be able to access items page if not login as admin" do
    get items_url
    assert_redirected_to login_url
    assert_equal 'you must be login first', flash[:notice]
  end
end
