require 'test_helper'

class MaterialVendorsControllerTest < ActionController::TestCase
  setup do
    @material_vendor = material_vendors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:material_vendors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create material_vendor" do
    assert_difference('MaterialVendor.count') do
      post :create, material_vendor: { date: @material_vendor.date, material_id: @material_vendor.material_id, vendor_id: @material_vendor.vendor_id }
    end

    assert_redirected_to material_vendor_path(assigns(:material_vendor))
  end

  test "should show material_vendor" do
    get :show, id: @material_vendor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @material_vendor
    assert_response :success
  end

  test "should update material_vendor" do
    patch :update, id: @material_vendor, material_vendor: { date: @material_vendor.date, material_id: @material_vendor.material_id, vendor_id: @material_vendor.vendor_id }
    assert_redirected_to material_vendor_path(assigns(:material_vendor))
  end

  test "should destroy material_vendor" do
    assert_difference('MaterialVendor.count', -1) do
      delete :destroy, id: @material_vendor
    end

    assert_redirected_to material_vendors_path
  end
end
