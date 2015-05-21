require 'test_helper'

class MaterialPropertiesControllerTest < ActionController::TestCase
  setup do
    @material_property = material_properties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:material_properties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create material_property" do
    assert_difference('MaterialProperty.count') do
      post :create, material_property: { material_id: @material_property.material_id, property_id: @material_property.property_id }
    end

    assert_redirected_to material_property_path(assigns(:material_property))
  end

  test "should show material_property" do
    get :show, id: @material_property
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @material_property
    assert_response :success
  end

  test "should update material_property" do
    patch :update, id: @material_property, material_property: { material_id: @material_property.material_id, property_id: @material_property.property_id }
    assert_redirected_to material_property_path(assigns(:material_property))
  end

  test "should destroy material_property" do
    assert_difference('MaterialProperty.count', -1) do
      delete :destroy, id: @material_property
    end

    assert_redirected_to material_properties_path
  end
end
