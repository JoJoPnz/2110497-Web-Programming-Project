require "test_helper"

# my_market page
class MyMarketTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:buyer1)
  end

  test "should show information" do
    get my_market_url
    assert_response :success
  end

  test "should not buy item if quantity less than or equal zero" do
    @item = items(:electronic1_enable)
    @market = Market.where(item_id: @item.id).first
    assert_no_difference 'Inventory.count' do
      post purchase_item_url(qty: 0, item_id: @item.id , lock_version:@market.lock_version)
    end
    assert_no_difference 'Inventory.count' do
      post purchase_item_url(qty: -1, item_id: @item.id , lock_version:@market.lock_version)
    end
    assert_redirected_to my_market_url
    assert_equal "quantity must be greater than 0", flash[:error]
  end

  test "should not buy item if item stock is less than quantity" do
    @item = items(:electronic1_enable)
    @market = Market.where(item_id: @item.id).first
    @stock = @market.stock
    @qty = @stock + 1
    assert_no_difference 'Inventory.count' do
      post purchase_item_url(qty: @qty, item_id: @item.id , lock_version:@market.lock_version)
    end
    assert_redirected_to my_market_url
    assert_equal "item stock is less than the quantity you want to buy", flash[:error]
  end

  test "should buy item successfully" do
    @item = items(:electronic1_enable)
    @market = Market.where(item_id: @item.id).first
    @stock = @market.stock
    @qty = @stock
    assert_difference 'Inventory.count', 1 do
      post purchase_item_url(qty: @qty, item_id: @item.id , lock_version:@market.lock_version)
    end
    assert_redirected_to my_market_url
    assert_equal 'purchase ' + @qty.to_s + ' ' + @item.name.to_s + ' successfully', flash[:success]
  end

  # Authentication test
  test "should not be able to access my_market page if not login" do
    get logout_url
    get my_market_url
    assert_redirected_to login_url
    assert_equal 'you must be login first', flash[:notice]
  end

  # Authorization test
  test "should not be able to access my_market page if login with seller account" do
    get logout_url
    sign_in_as users(:seller1)
    get my_market_url
    assert_redirected_to main_url
    assert_equal 'you must be buyer or admin to access this page', flash[:notice]
  end

end