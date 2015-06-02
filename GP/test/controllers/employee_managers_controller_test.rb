require 'test_helper'

class EmployeeManagersControllerTest < ActionController::TestCase
  setup do
    @employee_manager = employee_managers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employee_managers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employee_manager" do
    assert_difference('EmployeeManager.count') do
      post :create, employee_manager: { crew_id: @employee_manager.crew_id, employee_id: @employee_manager.employee_id, end_date: @employee_manager.end_date, start_date: @employee_manager.start_date }
    end

    assert_redirected_to employee_manager_path(assigns(:employee_manager))
  end

  test "should show employee_manager" do
    get :show, id: @employee_manager
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @employee_manager
    assert_response :success
  end

  test "should update employee_manager" do
    patch :update, id: @employee_manager, employee_manager: { crew_id: @employee_manager.crew_id, employee_id: @employee_manager.employee_id, end_date: @employee_manager.end_date, start_date: @employee_manager.start_date }
    assert_redirected_to employee_manager_path(assigns(:employee_manager))
  end

  test "should destroy employee_manager" do
    assert_difference('EmployeeManager.count', -1) do
      delete :destroy, id: @employee_manager
    end

    assert_redirected_to employee_managers_path
  end
end
