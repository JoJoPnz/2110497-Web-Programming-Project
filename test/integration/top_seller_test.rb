require "test_helper"

class TopSellerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:seller1)
  end

  test "should show information" do
    get top_seller_url
    assert_response :success
  end

  test "should search top seller successfully" do
    @filter = "filter_amount"
    @start_date = "12/01/2022"
    @end_date = "12/31/2022"
    post sort_top_seller_url(daterange: @start_date + ' - ' + @end_date, filter: @filter)
    assert_redirected_to top_seller_path + '/?filter=' + @filter + '&start_date=' + @start_date + '&end_date=' + @end_date
    assert_equal "Search Top Seller Succesfully", flash[:success]
  end

  test "should not search top seller without filter" do
    @start_date = "12/01/2022"
    @end_date = "12/31/2022"
    post sort_top_seller_url(daterange: @start_date + ' - ' + @end_date)
    assert_redirected_to top_seller_path
    assert_equal "Please Select Sort method (radio button)", flash[:alert]
  end

  test "should not search top seller without daterange" do
    @filter = "filter_amount"
    post sort_top_seller_url(filter: @filter)
    assert_redirected_to top_seller_path
    assert_equal "Please Select Date", flash[:alert]
  end

   # Authentication test
  test "should not be able to access top_seller page if not login" do
    get logout_url
    get top_seller_url
    assert_redirected_to login_url
    assert_equal 'you must be login first', flash[:notice]
  end

  # Authorization test
  test "should not be able to access top_seller page if login with buyer account" do
    get logout_url
    sign_in_as users(:buyer1)
    get top_seller_url
    assert_redirected_to main_url
    assert_equal 'you must be seller or admin to access this page', flash[:notice]
  end

end
