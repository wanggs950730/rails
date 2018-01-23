require 'test_helper'

class ImplyfriendshipsControllerTest < ActionController::TestCase
  setup do
    @implyfriendship = implyfriendships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:implyfriendships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create implyfriendship" do
    assert_difference('Implyfriendship.count') do
      post :create, implyfriendship: { create: @implyfriendship.create, destroy: @implyfriendship.destroy, friend_id: @implyfriendship.friend_id, user_id: @implyfriendship.user_id }
    end

    assert_redirected_to friendship_path(assigns(:implyfriendship))
  end

  test "should show implyfriendship" do
    get :show, id: @implyfriendship
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @implyfriendship
    assert_response :success
  end

  test "should update implyfriendship" do
    patch :update, id: @implyfriendship, friendship: { create: @implyfriendship.create, destroy: @fimplyriendship.destroy, friend_id: @implyfriendship.friend_id, user_id: @implyfriendship.user_id }
    assert_redirected_to friendship_path(assigns(:implyfriendship))
  end

  test "should destroy implyfriendship" do
    assert_difference('Implyfriendship.count', -1) do
      delete :destroy, id: @implyfriendship
    end

    assert_redirected_to implyfriendships_path
  end
end
