require 'test_helper'

class ProductionRatesControllerTest < ActionController::TestCase
  setup do
    @production_rate = production_rates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:production_rates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create production_rate" do
    assert_difference('ProductionRate.count') do
      post :create, production_rate: { number_of_panels_per_hour: @production_rate.number_of_panels_per_hour }
    end

    assert_redirected_to production_rate_path(assigns(:production_rate))
  end

  test "should show production_rate" do
    get :show, id: @production_rate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @production_rate
    assert_response :success
  end

  test "should update production_rate" do
    patch :update, id: @production_rate, production_rate: { number_of_panels_per_hour: @production_rate.number_of_panels_per_hour }
    assert_redirected_to production_rate_path(assigns(:production_rate))
  end

  test "should destroy production_rate" do
    assert_difference('ProductionRate.count', -1) do
      delete :destroy, id: @production_rate
    end

    assert_redirected_to production_rates_path
  end
end
