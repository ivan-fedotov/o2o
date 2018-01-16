require 'test_helper'

class PhotoReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get photo_reports_create_url
    assert_response :success
  end

end
