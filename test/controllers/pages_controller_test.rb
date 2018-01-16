require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get settings" do
    get pages_settings_url
    assert_response :success
  end

end
