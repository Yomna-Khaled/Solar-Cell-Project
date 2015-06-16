require 'test_helper'

class TheoreticalcategoriesControllerTest < ActionController::TestCase
  setup do
    @theoreticalcategory = theoreticalcategories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:theoreticalcategories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create theoreticalcategory" do
    assert_difference('Theoreticalcategory.count') do
      post :create, theoreticalcategory: { name: @theoreticalcategory.name }
    end

    assert_redirected_to theoreticalcategory_path(assigns(:theoreticalcategory))
  end

  test "should show theoreticalcategory" do
    get :show, id: @theoreticalcategory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @theoreticalcategory
    assert_response :success
  end

  test "should update theoreticalcategory" do
    patch :update, id: @theoreticalcategory, theoreticalcategory: { name: @theoreticalcategory.name }
    assert_redirected_to theoreticalcategory_path(assigns(:theoreticalcategory))
  end

  test "should destroy theoreticalcategory" do
    assert_difference('Theoreticalcategory.count', -1) do
      delete :destroy, id: @theoreticalcategory
    end

    assert_redirected_to theoreticalcategories_path
  end
end
