require 'test_helper'

class LookupPricesControllerTest < ActionController::TestCase
  setup do
    @lookup_price = lookup_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lookup_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lookup_price" do
    assert_difference('LookupPrice.count') do
      post :create, lookup_price: { name: @lookup_price.name, value: @lookup_price.value }
    end

    assert_redirected_to lookup_price_path(assigns(:lookup_price))
  end

  test "should show lookup_price" do
    get :show, id: @lookup_price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lookup_price
    assert_response :success
  end

  test "should update lookup_price" do
    patch :update, id: @lookup_price, lookup_price: { name: @lookup_price.name, value: @lookup_price.value }
    assert_redirected_to lookup_price_path(assigns(:lookup_price))
  end

  test "should destroy lookup_price" do
    assert_difference('LookupPrice.count', -1) do
      delete :destroy, id: @lookup_price
    end

    assert_redirected_to lookup_prices_path
  end
end
