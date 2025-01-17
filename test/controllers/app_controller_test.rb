require "test_helper"

class AppControllerTest < ActionDispatch::IntegrationTest
  test "should get createApp" do
    get app_createApp_url
    assert_response :success
  end
end
