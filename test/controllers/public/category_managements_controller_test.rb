require 'test_helper'

class Public::CategoryManagementsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_category_managements_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_category_managements_edit_url
    assert_response :success
  end

end
