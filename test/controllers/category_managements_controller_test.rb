require 'test_helper'

class CategoryManagementsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get category_managements_new_url
    assert_response :success
  end

  test "should get edit" do
    get category_managements_edit_url
    assert_response :success
  end

end
