require 'test_helper'

class SaledPanelsControllerTest < ActionController::TestCase
  setup do
    @saled_panel = saled_panels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:saled_panels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create saled_panel" do
    assert_difference('SaledPanel.count') do
      post :create, saled_panel: { buyer_id: @saled_panel.buyer_id, solar_panel_id: @saled_panel.solar_panel_id, totalPower: @saled_panel.totalPower, totalPrice: @saled_panel.totalPrice }
    end

    assert_redirected_to saled_panel_path(assigns(:saled_panel))
  end

  test "should show saled_panel" do
    get :show, id: @saled_panel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @saled_panel
    assert_response :success
  end

  test "should update saled_panel" do
    patch :update, id: @saled_panel, saled_panel: { buyer_id: @saled_panel.buyer_id, solar_panel_id: @saled_panel.solar_panel_id, totalPower: @saled_panel.totalPower, totalPrice: @saled_panel.totalPrice }
    assert_redirected_to saled_panel_path(assigns(:saled_panel))
  end

  test "should destroy saled_panel" do
    assert_difference('SaledPanel.count', -1) do
      delete :destroy, id: @saled_panel
    end

    assert_redirected_to saled_panels_path
  end
end
