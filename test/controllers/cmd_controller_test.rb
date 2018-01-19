require 'test_helper'

class CmdControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cmd_index_url
    assert_response :success
  end

end
