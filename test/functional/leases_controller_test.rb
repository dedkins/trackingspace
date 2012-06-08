require 'test_helper'

class LeasesControllerTest < ActionController::TestCase
  setup do
    @lease = leases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:leases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lease" do
    assert_difference('Lease.count') do
      post :create, lease: { current_rate: @lease.current_rate, expiration: @lease.expiration, size: @lease.size, space_id: @lease.space_id, user_id: @lease.user_id }
    end

    assert_redirected_to lease_path(assigns(:lease))
  end

  test "should show lease" do
    get :show, id: @lease
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lease
    assert_response :success
  end

  test "should update lease" do
    put :update, id: @lease, lease: { current_rate: @lease.current_rate, expiration: @lease.expiration, size: @lease.size, space_id: @lease.space_id, user_id: @lease.user_id }
    assert_redirected_to lease_path(assigns(:lease))
  end

  test "should destroy lease" do
    assert_difference('Lease.count', -1) do
      delete :destroy, id: @lease
    end

    assert_redirected_to leases_path
  end
end
