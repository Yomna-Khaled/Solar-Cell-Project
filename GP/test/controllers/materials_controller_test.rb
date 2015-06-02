require 'test_helper'

class MaterialsControllerTest < ActionController::TestCase
  setup do
    @material = materials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:materials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create material" do
    assert_difference('Material.count') do
      post :create, material: { Min_Number: @material.Min_Number, expiration_date: @material.expiration_date, name: @material.name, price: @material.price, production_date: @material.production_date, quantity: @material.quantity, quantity_id: @material.quantity_id, shelfNo: @material.shelfNo, stockNo: @material.stockNo }
    end

    assert_redirected_to material_path(assigns(:material))
  end

  test "should show material" do
    get :show, id: @material
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @material
    assert_response :success
  end

  test "should update material" do
    patch :update, id: @material, material: { Min_Number: @material.Min_Number, expiration_date: @material.expiration_date, name: @material.name, price: @material.price, production_date: @material.production_date, quantity: @material.quantity, quantity_id: @material.quantity_id, shelfNo: @material.shelfNo, stockNo: @material.stockNo }
    assert_redirected_to material_path(assigns(:material))
  end

  test "should destroy material" do
    assert_difference('Material.count', -1) do
      delete :destroy, id: @material
    end

    assert_redirected_to materials_path
  end
end
