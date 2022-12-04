require "application_system_test_case"

class MarketsTest < ApplicationSystemTestCase
  setup do
    @market = markets(:one)
  end

  test "visiting the index" do
    visit markets_url
    assert_selector "h1", text: "Markets"
  end

  test "should create market" do
    visit markets_url
    click_on "New market"

    fill_in "Item", with: @market.item_id
    fill_in "Price", with: @market.price
    fill_in "Stock", with: @market.stock
    fill_in "User", with: @market.user_id
    click_on "Create Market"

    assert_text "Market was successfully created"
    click_on "Back"
  end

  test "should update Market" do
    visit market_url(@market)
    click_on "Edit this market", match: :first

    fill_in "Item", with: @market.item_id
    fill_in "Price", with: @market.price
    fill_in "Stock", with: @market.stock
    fill_in "User", with: @market.user_id
    click_on "Update Market"

    assert_text "Market was successfully updated"
    click_on "Back"
  end

  test "should destroy Market" do
    visit market_url(@market)
    click_on "Destroy this market", match: :first

    assert_text "Market was successfully destroyed"
  end
end
