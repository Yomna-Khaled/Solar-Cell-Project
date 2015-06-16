require 'test_helper'

class SalesAdminsControllerTest < ActionController::TestCase
  setup do
    @sales_admin = sales_admins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sales_admins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sales_admin" do
    assert_difference('SalesAdmin.count') do
      post :create, sales_admin: { power: @sales_admin.power, subtype: @sales_admin.subtype, type: @sales_admin.type }
    end

    assert_redirected_to sales_admin_path(assigns(:sales_admin))
  end

  test "should show sales_admin" do
    get :show, id: @sales_admin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sales_admin
    assert_response :success
  end

  test "should update sales_admin" do
    patch :update, id: @sales_admin, sales_admin: { power: @sales_admin.power, subtype: @sales_admin.subtype, type: @sales_admin.type }
    assert_redirected_to sales_admin_path(assigns(:sales_admin))
  end

  test "should destroy sales_admin" do
    assert_difference('SalesAdmin.count', -1) do
      delete :destroy, id: @sales_admin
    end

    assert_redirected_to sales_admins_path
  end
end
