require 'test_helper'

class Public::SellItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_sell_items_index_url
    assert_response :success
  end

  test "should get show" do
    get public_sell_items_show_url
    assert_response :success
  end

  test "should get order_new" do
    get public_sell_items_order_new_url
    assert_response :success
  end

  test "should get confirm" do
    get public_sell_items_confirm_url
    assert_response :success
  end

  test "should get thanks" do
    get public_sell_items_thanks_url
    assert_response :success
  end

  test "should get new" do
    get public_sell_items_new_url
    assert_response :success
  end

end
