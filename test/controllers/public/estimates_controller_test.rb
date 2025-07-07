require "test_helper"

class Public::EstimatesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_estimates_new_url
    assert_response :success
  end

  test "should get create" do
    get public_estimates_create_url
    assert_response :success
  end

  test "should get show" do
    get public_estimates_show_url
    assert_response :success
  end
end
