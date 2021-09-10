require 'test_helper'

class Public::ChartsControllerTest < ActionDispatch::IntegrationTest
  test "should get purchase" do
    get public_charts_purchase_url
    assert_response :success
  end

  test "should get disposal" do
    get public_charts_disposal_url
    assert_response :success
  end

  test "should get index" do
    get public_charts_index_url
    assert_response :success
  end

end
