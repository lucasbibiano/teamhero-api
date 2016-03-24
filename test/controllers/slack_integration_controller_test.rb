require 'test_helper'

class SlackIntegrationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get slack_integration_index_url
    assert_response :success
  end

end
