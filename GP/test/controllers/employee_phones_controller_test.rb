require 'test_helper'

class EmployeePhonesControllerTest < ActionController::TestCase
  setup do
    @employee_phone = employee_phones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employee_phones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employee_phone" do
    assert_difference('EmployeePhone.count') do
      post :create, employee_phone: { employee_id: @employee_phone.employee_id, phone: @employee_phone.phone }
    end

    assert_redirected_to employee_phone_path(assigns(:employee_phone))
  end

  test "should show employee_phone" do
    get :show, id: @employee_phone
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @employee_phone
    assert_response :success
  end

  test "should update employee_phone" do
    patch :update, id: @employee_phone, employee_phone: { employee_id: @employee_phone.employee_id, phone: @employee_phone.phone }
    assert_redirected_to employee_phone_path(assigns(:employee_phone))
  end

  test "should destroy employee_phone" do
    assert_difference('EmployeePhone.count', -1) do
      delete :destroy, id: @employee_phone
    end

    assert_redirected_to employee_phones_path
  end
end
