require 'test_helper'

class Admin::SellItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_sell_items_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_sell_items_show_url
    assert_response :success
  end

end
