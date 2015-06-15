require 'test_helper'

class MaterialTheoreticalsControllerTest < ActionController::TestCase
  setup do
    @material_theoretical = material_theoreticals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:material_theoreticals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create material_theoretical" do
    assert_difference('MaterialTheoretical.count') do
      post :create, material_theoretical: { value: @material_theoretical.value }
    end

    assert_redirected_to material_theoretical_path(assigns(:material_theoretical))
  end

  test "should show material_theoretical" do
    get :show, id: @material_theoretical
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @material_theoretical
    assert_response :success
  end

  test "should update material_theoretical" do
    patch :update, id: @material_theoretical, material_theoretical: { value: @material_theoretical.value }
    assert_redirected_to material_theoretical_path(assigns(:material_theoretical))
  end

  test "should destroy material_theoretical" do
    assert_difference('MaterialTheoretical.count', -1) do
      delete :destroy, id: @material_theoretical
    end

    assert_redirected_to material_theoreticals_path
  end
end
