require 'test_helper'

class VendorSparesControllerTest < ActionController::TestCase
  setup do
    @vendor_spare = vendor_spares(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vendor_spares)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vendor_spare" do
    assert_difference('VendorSpare.count') do
      post :create, vendor_spare: { date: @vendor_spare.date, spare_part_id: @vendor_spare.spare_part_id, vendor_id: @vendor_spare.vendor_id }
    end

    assert_redirected_to vendor_spare_path(assigns(:vendor_spare))
  end

  test "should show vendor_spare" do
    get :show, id: @vendor_spare
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vendor_spare
    assert_response :success
  end

  test "should update vendor_spare" do
    patch :update, id: @vendor_spare, vendor_spare: { date: @vendor_spare.date, spare_part_id: @vendor_spare.spare_part_id, vendor_id: @vendor_spare.vendor_id }
    assert_redirected_to vendor_spare_path(assigns(:vendor_spare))
  end

  test "should destroy vendor_spare" do
    assert_difference('VendorSpare.count', -1) do
      delete :destroy, id: @vendor_spare
    end

    assert_redirected_to vendor_spares_path
  end
end
