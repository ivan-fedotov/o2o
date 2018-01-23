require 'test_helper'

class TicketDescriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticket_description = ticket_descriptions(:one)
  end

  test "should get index" do
    get ticket_descriptions_url
    assert_response :success
  end

  test "should get new" do
    get new_ticket_description_url
    assert_response :success
  end

  test "should create ticket_description" do
    assert_difference('TicketDescription.count') do
      post ticket_descriptions_url, params: { ticket_description: { title: @ticket_description.title } }
    end

    assert_redirected_to ticket_description_url(TicketDescription.last)
  end

  test "should show ticket_description" do
    get ticket_description_url(@ticket_description)
    assert_response :success
  end

  test "should get edit" do
    get edit_ticket_description_url(@ticket_description)
    assert_response :success
  end

  test "should update ticket_description" do
    patch ticket_description_url(@ticket_description), params: { ticket_description: { title: @ticket_description.title } }
    assert_redirected_to ticket_description_url(@ticket_description)
  end

  test "should destroy ticket_description" do
    assert_difference('TicketDescription.count', -1) do
      delete ticket_description_url(@ticket_description)
    end

    assert_redirected_to ticket_descriptions_url
  end
end
