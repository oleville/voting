require 'test_helper'

class BallotsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get ballots_create_url
    assert_response :success
  end

  test "should get show" do
    get ballots_show_url
    assert_response :success
  end

end
