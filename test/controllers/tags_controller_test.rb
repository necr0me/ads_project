require "test_helper"

class TagsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get tags_new_url
    assert_response :success
  end

  test "should get update" do
    get tags_update_url
    assert_response :success
  end

  test "should get destroy" do
    get tags_destroy_url
    assert_response :success
  end
end
