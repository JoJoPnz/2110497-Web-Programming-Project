require "application_system_test_case"

class MyInventoriesTest < ApplicationSystemTestCase
  # setup do
  #   sign_in_as users(:seller1)
  # end

  # test "should show information" do
  #   visit my_inventory_url
  #   assert_selector "#my_inventory_table"
  # end

  # test "edit amount item" do
  #   visit my_inventory_url
  #   assert_selector "th", text: "Edit Amount"
  #   fill_in "qty", match: :first, with:12
  #   click_on "Submit", match: :first
  #   assert_text "Amount of item has been changed"
  # end

  # test "edit amount item to less than zero" do
  #   visit my_inventory_url
  #   assert_selector "th", text: "Edit Amount"
  #   fill_in "qty", match: :first, with:-12
  #   click_on "Submit", match: :first
  #   assert_text "Amount of item cannot be less than zero"
  # end

  # test "add new item with price and stock more than zero" do
  #   visit my_inventory_url
  #   click_on "Add new item"
  #   click_on "Back"
  #   click_on "Add new item"

  #   assert_selector "label", text: "Name"
  #   fill_in "Name", with:'Oreo'
  #   assert_selector "label", text: "Category"
  #   fill_in "Category", with:'Food'
  #   assert_selector "label", text: "Price"
  #   fill_in "Price", with: 10
  #   assert_selector "label", text: "Stock"
  #   fill_in "Stock", with:10
  #   click_on "Save"
  #   assert_text "The item has been added"
  # end

  # test "delete item" do
  #   visit my_inventory_url
  #   assert_selector "#my_inventory_table"
  #   assert_selector "th", text: "Delete"
  #   click_on "DELETE", match: :first
  #   assert_text "The item has been deleted"
  # end

  # test "add new item with price and stock less than zero and not fill all the field" do
  #   visit my_inventory_url
  #   click_on "Add new item"

  #   click_on "Save"
  #   assert_text "name, category, price, stock must be filled"

  #   assert_selector "label", text: "Name"
  #   fill_in "Name", with:'Oreo'
  #   assert_selector "label", text: "Category"
  #   fill_in "Category", with:'Food'
  #   assert_selector "label", text: "Price"
  #   fill_in "Price", with: -1
  #   assert_selector "label", text: "Stock"
  #   fill_in "Stock", with:10
  #   click_on "Save"
  #   assert_text "price is not allowed to be zero or less than zero"

  #   assert_selector "label", text: "Name"
  #   fill_in "Name", with:'Oreo'
  #   assert_selector "label", text: "Category"
  #   fill_in "Category", with:'Food'
  #   assert_selector "label", text: "Price"
  #   fill_in "Price", with: 10
  #   assert_selector "label", text: "Stock"
  #   fill_in "Stock", with: -50
  #   click_on "Save"
  #   assert_text "stock is not allowed to be less than zero"
  # end

end
