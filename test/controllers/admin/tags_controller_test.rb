require "test_helper"

class Admin::TagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_tags_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_tags_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_tags_create_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_tags_destroy_url
    assert_response :success
  end
end
