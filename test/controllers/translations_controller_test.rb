require "test_helper"

class TranslationsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get translations_search_url
    assert_response :success
  end

  test "should get result" do
    get translations_result_url
    assert_response :success
  end

  test "should get save" do
    get translations_save_url
    assert_response :success
  end
end
