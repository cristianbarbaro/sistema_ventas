require 'test_helper'

class StocksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stocks_index_url
    assert_response :success
  end

  test "should get show" do
    get stocks_show_url
    assert_response :success
  end

  test "should get new" do
    get stocks_new_url
    assert_response :success
  end

  test "should get edit" do
    get stocks_edit_url
    assert_response :success
  end

  test "should get create" do
    get stocks_create_url
    assert_response :success
  end

  test "should get update" do
    get stocks_update_url
    assert_response :success
  end

  test "should get destroy" do
    get stocks_destroy_url
    assert_response :success
  end

end
