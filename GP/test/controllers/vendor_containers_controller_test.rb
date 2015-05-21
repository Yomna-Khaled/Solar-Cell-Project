require 'test_helper'

class VendorContainersControllerTest < ActionController::TestCase
  setup do
    @vendor_container = vendor_containers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vendor_containers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vendor_container" do
    assert_difference('VendorContainer.count') do
      post :create, vendor_container: { container_id: @vendor_container.container_id, date: @vendor_container.date, vendor_id: @vendor_container.vendor_id }
    end

    assert_redirected_to vendor_container_path(assigns(:vendor_container))
  end

  test "should show vendor_container" do
    get :show, id: @vendor_container
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vendor_container
    assert_response :success
  end

  test "should update vendor_container" do
    patch :update, id: @vendor_container, vendor_container: { container_id: @vendor_container.container_id, date: @vendor_container.date, vendor_id: @vendor_container.vendor_id }
    assert_redirected_to vendor_container_path(assigns(:vendor_container))
  end

  test "should destroy vendor_container" do
    assert_difference('VendorContainer.count', -1) do
      delete :destroy, id: @vendor_container
    end

    assert_redirected_to vendor_containers_path
  end
end
