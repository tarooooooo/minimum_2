require 'test_helper'

class Admin::ColorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_colors_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_colors_edit_url
    assert_response :success
  end

end
