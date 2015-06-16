require 'test_helper'

class MaterialTheoreticalCategoriesControllerTest < ActionController::TestCase
  setup do
    @material_theoretical_category = material_theoretical_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:material_theoretical_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create material_theoretical_category" do
    assert_difference('MaterialTheoreticalCategory.count') do
      post :create, material_theoretical_category: { Material_id: @material_theoretical_category.Material_id, Theoretical_Category_id: @material_theoretical_category.Theoretical_Category_id, value: @material_theoretical_category.value }
    end

    assert_redirected_to material_theoretical_category_path(assigns(:material_theoretical_category))
  end

  test "should show material_theoretical_category" do
    get :show, id: @material_theoretical_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @material_theoretical_category
    assert_response :success
  end

  test "should update material_theoretical_category" do
    patch :update, id: @material_theoretical_category, material_theoretical_category: { Material_id: @material_theoretical_category.Material_id, Theoretical_Category_id: @material_theoretical_category.Theoretical_Category_id, value: @material_theoretical_category.value }
    assert_redirected_to material_theoretical_category_path(assigns(:material_theoretical_category))
  end

  test "should destroy material_theoretical_category" do
    assert_difference('MaterialTheoreticalCategory.count', -1) do
      delete :destroy, id: @material_theoretical_category
    end

    assert_redirected_to material_theoretical_categories_path
  end
end
