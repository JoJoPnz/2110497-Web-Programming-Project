require "application_system_test_case"

class MainTest < ApplicationSystemTestCase

#  test "should show information for admin" do
#     sign_in_as users(:admin1)
#     @profile_menus = ["View Profile", "Change Password"]
#     @profile_menus.each do |menu|
#       visit main_url
#       assert_selector "a", text: "Profile"
#       click_on "Profile"
#       assert_selector "a.dropdown-item", text: menu
#       click_on menu
#     end
#     @menus = ["Market", "Purchase History", "Inventory", "Sale History", "Top Seller", "Logout"]
#     @menus.each do |menu|
#       visit main_url
#       assert_selector "a", text: menu
#       click_on menu
#     end
#   end

#   test "should show information for seller" do
#     sign_in_as users(:seller1)
#     @profile_menus = ["View Profile", "Change Password"]
#     @profile_menus.each do |menu|
#       visit main_url
#       assert_selector "a", text: "Profile"
#       click_on "Profile"
#       assert_selector "a.dropdown-item", text: menu
#       click_on menu
#     end
#     @menus = ["Inventory", "Sale History", "Top Seller", "Logout"]
#     @menus.each do |menu|
#       visit main_url
#       assert_selector "a", text: menu
#       click_on menu
#     end
#   end

#   test "should show information for buyer" do
#     sign_in_as users(:buyer1)
#     @profile_menus = ["View Profile", "Change Password"]
#     @profile_menus.each do |menu|
#       visit main_url
#       assert_selector "a", text: "Profile"
#       click_on "Profile"
#       assert_selector "a.dropdown-item", text: menu
#       click_on menu
#     end
#     @menus = ["Market", "Purchase History", "Logout"]
#     @menus.each do |menu|
#       visit main_url
#       assert_selector "a", text: menu
#       click_on menu
#     end
#   end



end
