require "application_system_test_case"

class TopSellerTest < ApplicationSystemTestCase
  setup do
    sign_in_as users(:seller1)
  end

  test "should show information" do
    visit top_seller_url
    assert_selector "#daterange"
    assert_selector "input#filter_amount"
    assert_selector "input#filter_sale"
    assert_selector "input[value=Search][type=submit]"
  end

  test "should search top seller successfully" do
    visit top_seller_url
    assert_selector "#daterange"
    fill_in "daterange", with: "12/01/2022 - 12/31/2022"
    assert_selector "input#filter_amount"
    choose(option: 'filter_amount')
    click_on "Search"
    assert_selector "table#filter_table"
  end

end
