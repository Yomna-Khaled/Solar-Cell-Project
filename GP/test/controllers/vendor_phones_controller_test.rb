require 'test_helper'

class VendorPhonesControllerTest < ActionController::TestCase
  setup do
    @vendor_phone = vendor_phones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vendor_phones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vendor_phone" do
    assert_difference('VendorPhone.count') do
      post :create, vendor_phone: { phone: @vendor_phone.phone, vendor_id: @vendor_phone.vendor_id }
    end

    assert_redirected_to vendor_phone_path(assigns(:vendor_phone))
  end

  test "should show vendor_phone" do
    get :show, id: @vendor_phone
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vendor_phone
    assert_response :success
  end

  test "should update vendor_phone" do
    patch :update, id: @vendor_phone, vendor_phone: { phone: @vendor_phone.phone, vendor_id: @vendor_phone.vendor_id }
    assert_redirected_to vendor_phone_path(assigns(:vendor_phone))
  end

  test "should destroy vendor_phone" do
    assert_difference('VendorPhone.count', -1) do
      delete :destroy, id: @vendor_phone
    end

    assert_redirected_to vendor_phones_path
  end
end
