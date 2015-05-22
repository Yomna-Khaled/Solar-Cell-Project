require 'test_helper'

class ProductionShiftsControllerTest < ActionController::TestCase
  setup do
    @production_shift = production_shifts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:production_shifts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create production_shift" do
    assert_difference('ProductionShift.count') do
      post :create, production_shift: { material_id: @production_shift.material_id, material_quantity: @production_shift.material_quantity, shift_id: @production_shift.shift_id }
    end

    assert_redirected_to production_shift_path(assigns(:production_shift))
  end

  test "should show production_shift" do
    get :show, id: @production_shift
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @production_shift
    assert_response :success
  end

  test "should update production_shift" do
    patch :update, id: @production_shift, production_shift: { material_id: @production_shift.material_id, material_quantity: @production_shift.material_quantity, shift_id: @production_shift.shift_id }
    assert_redirected_to production_shift_path(assigns(:production_shift))
  end

  test "should destroy production_shift" do
    assert_difference('ProductionShift.count', -1) do
      delete :destroy, id: @production_shift
    end

    assert_redirected_to production_shifts_path
  end
end
