require 'test_helper'

class ArsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get ars_create_url
    assert_response :success
  end

  test "should get destroy" do
    get ars_destroy_url
    assert_response :success
  end

end
