require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end

# =====

module SignInHelper
  def sign_in_as(user)
    visit login_url
    fill_in "email", with: user.email
    fill_in "password", with: "password"
    click_on "OK"
  end
end

class ActionDispatch::SystemTestCase
  include SignInHelper
end