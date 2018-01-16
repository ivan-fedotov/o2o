require 'test_helper'

class SitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site = sites(:one)
  end

  test "should get index" do
    get sites_url
    assert_response :success
  end

  test "should get new" do
    get new_site_url
    assert_response :success
  end

  test "should create site" do
    assert_difference('Site.count') do
      post sites_url, params: { site: { access_info: @site.access_info, adress_info: @site.adress_info, distance: @site.distance, etc: @site.etc, keys_info: @site.keys_info, network_name: @site.network_name, power_info: @site.power_info } }
    end

    assert_redirected_to site_url(Site.last)
  end

  test "should show site" do
    get site_url(@site)
    assert_response :success
  end

  test "should get edit" do
    get edit_site_url(@site)
    assert_response :success
  end

  test "should update site" do
    patch site_url(@site), params: { site: { access_info: @site.access_info, adress_info: @site.adress_info, distance: @site.distance, etc: @site.etc, keys_info: @site.keys_info, network_name: @site.network_name, power_info: @site.power_info } }
    assert_redirected_to site_url(@site)
  end

  test "should destroy site" do
    assert_difference('Site.count', -1) do
      delete site_url(@site)
    end

    assert_redirected_to sites_url
  end
end
