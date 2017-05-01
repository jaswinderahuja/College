require 'test_helper'

class CampusDrivesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get campus_drives_create_url
    assert_response :success
  end

  test "should get index" do
    get campus_drives_index_url
    assert_response :success
  end

end
