require 'test_helper'

class PRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @p_role = p_roles(:one)
  end

  test "should get index" do
    get p_roles_url
    assert_response :success
  end

  test "should get new" do
    get new_p_role_url
    assert_response :success
  end

  test "should create p_role" do
    assert_difference('PRole.count') do
      post p_roles_url, params: { p_role: { permissions: @p_role.permissions, title: @p_role.title } }
    end

    assert_redirected_to p_role_url(PRole.last)
  end

  test "should show p_role" do
    get p_role_url(@p_role)
    assert_response :success
  end

  test "should get edit" do
    get edit_p_role_url(@p_role)
    assert_response :success
  end

  test "should update p_role" do
    patch p_role_url(@p_role), params: { p_role: { permissions: @p_role.permissions, title: @p_role.title } }
    assert_redirected_to p_role_url(@p_role)
  end

  test "should destroy p_role" do
    assert_difference('PRole.count', -1) do
      delete p_role_url(@p_role)
    end

    assert_redirected_to p_roles_url
  end
end
