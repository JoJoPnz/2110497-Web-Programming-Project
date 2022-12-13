require "application_system_test_case"

class MyMarketTest < ApplicationSystemTestCase
  setup do
    sign_in_as users(:buyer1)
  end

  test "should show information" do
    visit my_market_url
    assert_selector "#my_market_table"
  end

  test "should search by category" do
    visit my_market_url
    @item = items(:electronic1_enable)
    assert_selector "label", text: "Search By Category"
    fill_in "Search By Category", with: @item.category
    assert_selector "td", text: @item.category
  end

end
