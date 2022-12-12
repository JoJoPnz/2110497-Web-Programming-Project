require "test_helper"

# purchase_history page
class PurchaseHistoryTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:buyer1)
  end

  test "should show information" do
    get purchase_history_url
    assert_response :success
  end

  # Authentication test
  test "should not be able to access purchase_history page if not login" do
    get logout_url
    get purchase_history_url
    assert_redirected_to login_url
    assert_equal 'you must be login first', flash[:notice]
  end

  # Authorization test
  test "should not be able to access purchase_history page if login with seller account" do
    get logout_url
    sign_in_as users(:seller1)
    get purchase_history_url
    assert_redirected_to main_url
    assert_equal 'you must be buyer or admin to access this page', flash[:notice]
  end

end
