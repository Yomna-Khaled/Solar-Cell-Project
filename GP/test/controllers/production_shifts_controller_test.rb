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
      post :create, production_shift: { crew_id: @production_shift.crew_id, end_shift: @production_shift.end_shift, material_id: @production_shift.material_id, solar_panel_id: @production_shift.solar_panel_id, start_shift: @production_shift.start_shift }
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
    patch :update, id: @production_shift, production_shift: { crew_id: @production_shift.crew_id, end_shift: @production_shift.end_shift, material_id: @production_shift.material_id, solar_panel_id: @production_shift.solar_panel_id, start_shift: @production_shift.start_shift }
    assert_redirected_to production_shift_path(assigns(:production_shift))
  end

  test "should destroy production_shift" do
    assert_difference('ProductionShift.count', -1) do
      delete :destroy, id: @production_shift
    end

    assert_redirected_to production_shifts_path
  end
end
