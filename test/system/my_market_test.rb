require "application_system_test_case"

class MyMarketTest < ApplicationSystemTestCase
  setup do
    @buyer = users(:buyer1)
    visit login_url
    fill_in "email", with: @buyer.email
    fill_in "password", with: "password"
    click_on "OK"
  end

  # test "should show information" do
  #   visit my_market_url
  #   assert_selector "#my_market_table"
  # end

  # test "should search by category" do
  #   visit my_market_url
  #   @item = items(:electronic1_enable)
  #   assert_selector "label", text: "Search By Category"
  #   fill_in "Search By Category", with: @item.category
  #   assert_selector "td", text: @item.category
  # end

end
