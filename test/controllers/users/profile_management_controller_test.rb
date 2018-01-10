require 'test_helper'

class Users::ProfileManagementControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_profile_management_index_url
    assert_response :success
  end

end
