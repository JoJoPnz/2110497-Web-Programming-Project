require "application_system_test_case"

class ProfilesTest < ApplicationSystemTestCase
  setup do
    sign_in_as users(:buyer1)
  end

  test "should show information" do
    visit profile_url
    assert_selector "#profile_table"
  end

  test "should edit password with matching password" do
    visit profile_url
    click_on "Edit password"
    click_on "Back to Profile page"
    click_on "Edit password"
    assert_selector "label", text: "New password"
    fill_in "new_password", with:'123456'

    assert_selector "label", text: "Confirm password"
    fill_in "confirm_password", with:'123456'
    click_on "Save"
  end
end
