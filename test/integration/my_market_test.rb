require "test_helper"

class MyMarketTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:buyer1)
  end

  # my_market page
  test "should show information" do
    get my_market_url
    assert_response :success
  end

  test "should not buy item if quantity less than or equal zero" do
    @item = items(:electronic1_enable)
    assert_no_difference 'Inventory.count' do
      post purchase_item_url(qty: -1, item_id: @item.id)
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
      post purchase_item_url(qty: @qty, item_id: @item.id)
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
      post purchase_item_url(qty: @qty, item_id: @item.id)
    end
    assert_redirected_to my_market_url
    assert_equal 'purchase ' + @qty.to_s + ' ' + @item.name.to_s + ' successfully', flash[:success]
  end

  # my_inventory page



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





  # test "should get index" do
  #   get markets_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_market_url
  #   assert_response :success
  # end

  # test "should create market" do
  #   assert_difference("Market.count") do
  #     post markets_url, params: { market: { item_id: @market.item_id, price: @market.price, stock: @market.stock, user_id: @market.user_id } }
  #   end

  #   assert_redirected_to market_url(Market.last)
  # end

  # test "should show market" do
  #   get market_url(@market)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_market_url(@market)
  #   assert_response :success
  # end

  # test "should update market" do
  #   patch market_url(@market), params: { market: { item_id: @market.item_id, price: @market.price, stock: @market.stock, user_id: @market.user_id } }
  #   assert_redirected_to market_url(@market)
  # end

  # test "should destroy market" do
  #   assert_difference("Market.count", -1) do
  #     delete market_url(@market)
  #   end

  #   assert_redirected_to markets_url
  # end
end