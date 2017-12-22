require 'test_helper'

class UserHelpControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_help_index_url
    assert_response :success
  end

end
