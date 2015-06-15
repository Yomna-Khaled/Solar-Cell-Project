require 'test_helper'

class TheoreticalCategoriesControllerTest < ActionController::TestCase
  setup do
    @theoretical_category = theoretical_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:theoretical_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create theoretical_category" do
    assert_difference('TheoreticalCategory.count') do
      post :create, theoretical_category: { name: @theoretical_category.name }
    end

    assert_redirected_to theoretical_category_path(assigns(:theoretical_category))
  end

  test "should show theoretical_category" do
    get :show, id: @theoretical_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @theoretical_category
    assert_response :success
  end

  test "should update theoretical_category" do
    patch :update, id: @theoretical_category, theoretical_category: { name: @theoretical_category.name }
    assert_redirected_to theoretical_category_path(assigns(:theoretical_category))
  end

  test "should destroy theoretical_category" do
    assert_difference('TheoreticalCategory.count', -1) do
      delete :destroy, id: @theoretical_category
    end

    assert_redirected_to theoretical_categories_path
  end
end
