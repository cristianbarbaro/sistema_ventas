require 'test_helper'

class ProvidersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get providers_index_url
    assert_response :success
  end

  test "should get show" do
    get providers_show_url
    assert_response :success
  end

  test "should get new" do
    get providers_new_url
    assert_response :success
  end

  test "should get edit" do
    get providers_edit_url
    assert_response :success
  end

  test "should get create" do
    get providers_create_url
    assert_response :success
  end

  test "should get update" do
    get providers_update_url
    assert_response :success
  end

  test "should get destroy" do
    get providers_destroy_url
    assert_response :success
  end

end
