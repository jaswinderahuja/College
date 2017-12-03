require 'test_helper'

class ConnectionsDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get connections_dashboard_index_url
    assert_response :success
  end

end
