require "application_system_test_case"

class PurchaseHistoryTest < ApplicationSystemTestCase
  setup do
    @buyer = users(:buyer1)
    visit login_url
    fill_in "email", with: @buyer.email
    fill_in "password", with: "password"
    click_on "OK"
  end

#   test "should show information" do
#     visit purchase_history_url
#     assert_selector "#purchase_history_table"
#   end

end
