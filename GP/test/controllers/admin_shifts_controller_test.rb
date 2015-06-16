require 'test_helper'

class AdminShiftsControllerTest < ActionController::TestCase
  setup do
    @admin_shift = admin_shifts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_shifts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_shift" do
    assert_difference('AdminShift.count') do
      post :create, admin_shift: { employee_id: @admin_shift.employee_id, power: @admin_shift.power, subtype: @admin_shift.subtype, type: @admin_shift.type }
    end

    assert_redirected_to admin_shift_path(assigns(:admin_shift))
  end

  test "should show admin_shift" do
    get :show, id: @admin_shift
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_shift
    assert_response :success
  end

  test "should update admin_shift" do
    patch :update, id: @admin_shift, admin_shift: { employee_id: @admin_shift.employee_id, power: @admin_shift.power, subtype: @admin_shift.subtype, type: @admin_shift.type }
    assert_redirected_to admin_shift_path(assigns(:admin_shift))
  end

  test "should destroy admin_shift" do
    assert_difference('AdminShift.count', -1) do
      delete :destroy, id: @admin_shift
    end

    assert_redirected_to admin_shifts_path
  end
end
