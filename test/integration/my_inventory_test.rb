require "test_helper"

class MyInventoryTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:buyer1)
  end
  
  # Authentication test
  test "should not be able to access my_inventory page if not login" do
    get logout_url
    get my_inventory_url
    assert_redirected_to login_url
    assert_equal 'you must be login first', flash[:notice]
  end

  # Authorization test
  test "should not be able to access my_inventory page if login with buyer account" do
    get logout_url
    sign_in_as users(:buyer1)
    get my_inventory_url
    assert_redirected_to main_url
    assert_equal 'you must be seller or admin to access this page', flash[:notice]
  end
end
