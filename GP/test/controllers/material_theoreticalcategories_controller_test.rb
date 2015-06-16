require 'test_helper'

class MaterialTheoreticalcategoriesControllerTest < ActionController::TestCase
  setup do
    @material_theoreticalcategory = material_theoreticalcategories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:material_theoreticalcategories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create material_theoreticalcategory" do
    assert_difference('MaterialTheoreticalcategory.count') do
      post :create, material_theoreticalcategory: { Material_id: @material_theoreticalcategory.Material_id, Theoreticalcategory_id: @material_theoreticalcategory.Theoreticalcategory_id, value: @material_theoreticalcategory.value }
    end

    assert_redirected_to material_theoreticalcategory_path(assigns(:material_theoreticalcategory))
  end

  test "should show material_theoreticalcategory" do
    get :show, id: @material_theoreticalcategory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @material_theoreticalcategory
    assert_response :success
  end

  test "should update material_theoreticalcategory" do
    patch :update, id: @material_theoreticalcategory, material_theoreticalcategory: { Material_id: @material_theoreticalcategory.Material_id, Theoreticalcategory_id: @material_theoreticalcategory.Theoreticalcategory_id, value: @material_theoreticalcategory.value }
    assert_redirected_to material_theoreticalcategory_path(assigns(:material_theoreticalcategory))
  end

  test "should destroy material_theoreticalcategory" do
    assert_difference('MaterialTheoreticalcategory.count', -1) do
      delete :destroy, id: @material_theoreticalcategory
    end

    assert_redirected_to material_theoreticalcategories_path
  end
end
