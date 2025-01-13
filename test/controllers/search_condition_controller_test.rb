require "test_helper"

class SearchConditionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get search_condition_index_url
    assert_response :success
  end
end
