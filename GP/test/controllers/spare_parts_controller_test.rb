require 'test_helper'

class SparePartsControllerTest < ActionController::TestCase
  setup do
    @spare_part = spare_parts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spare_parts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spare_part" do
    assert_difference('SparePart.count') do
      post :create, spare_part: { material_id: @spare_part.material_id, name: @spare_part.name, price: @spare_part.price, quantity: @spare_part.quantity }
    end

    assert_redirected_to spare_part_path(assigns(:spare_part))
  end

  test "should show spare_part" do
    get :show, id: @spare_part
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @spare_part
    assert_response :success
  end

  test "should update spare_part" do
    patch :update, id: @spare_part, spare_part: { material_id: @spare_part.material_id, name: @spare_part.name, price: @spare_part.price, quantity: @spare_part.quantity }
    assert_redirected_to spare_part_path(assigns(:spare_part))
  end

  test "should destroy spare_part" do
    assert_difference('SparePart.count', -1) do
      delete :destroy, id: @spare_part
    end

    assert_redirected_to spare_parts_path
  end
end
