require 'test_helper'

class BuyerPhonesControllerTest < ActionController::TestCase
  setup do
    @buyer_phone = buyer_phones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:buyer_phones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create buyer_phone" do
    assert_difference('BuyerPhone.count') do
      post :create, buyer_phone: { buyer_id: @buyer_phone.buyer_id, phone: @buyer_phone.phone }
    end

    assert_redirected_to buyer_phone_path(assigns(:buyer_phone))
  end

  test "should show buyer_phone" do
    get :show, id: @buyer_phone
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @buyer_phone
    assert_response :success
  end

  test "should update buyer_phone" do
    patch :update, id: @buyer_phone, buyer_phone: { buyer_id: @buyer_phone.buyer_id, phone: @buyer_phone.phone }
    assert_redirected_to buyer_phone_path(assigns(:buyer_phone))
  end

  test "should destroy buyer_phone" do
    assert_difference('BuyerPhone.count', -1) do
      delete :destroy, id: @buyer_phone
    end

    assert_redirected_to buyer_phones_path
  end
end
