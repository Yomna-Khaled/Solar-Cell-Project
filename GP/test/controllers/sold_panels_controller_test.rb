require 'test_helper'

class SoldPanelsControllerTest < ActionController::TestCase
  setup do
    @sold_panel = sold_panels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sold_panels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sold_panel" do
    assert_difference('SoldPanel.count') do
      post :create, sold_panel: { buyer_id: @sold_panel.buyer_id, totalPower: @sold_panel.totalPower, totalPrice: @sold_panel.totalPrice }
    end

    assert_redirected_to sold_panel_path(assigns(:sold_panel))
  end

  test "should show sold_panel" do
    get :show, id: @sold_panel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sold_panel
    assert_response :success
  end

  test "should update sold_panel" do
    patch :update, id: @sold_panel, sold_panel: { buyer_id: @sold_panel.buyer_id, totalPower: @sold_panel.totalPower, totalPrice: @sold_panel.totalPrice }
    assert_redirected_to sold_panel_path(assigns(:sold_panel))
  end

  test "should destroy sold_panel" do
    assert_difference('SoldPanel.count', -1) do
      delete :destroy, id: @sold_panel
    end

    assert_redirected_to sold_panels_path
  end
end
