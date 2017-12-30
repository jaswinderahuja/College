require 'test_helper'

class ProfileManagementControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get profile_management_index_url
    assert_response :success
  end

end
