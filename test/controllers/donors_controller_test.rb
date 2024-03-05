require 'test_helper'

class DonorsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should show donor" do
    donor = Donor.create(name: "Example Donor", email: "example@example.com")
    get :show, params: { id: donor.id }
    assert_response :success
  end

  test "should create donor" do
    assert_difference('Donor.count') do
      post :create, params: { donor: { name: "New Donor", email: "new@example.com" } }
    end
    assert_response :success
  end

  test "should update donor" do
    donor = Donor.create(name: "Example Donor", email: "example@example.com")
    put :update, params: { id: donor.id, donor: { name: "Updated Donor" } }
    donor.reload
    assert_equal "Updated Donor", donor.name
    assert_response :success
  end

  test "should destroy donor" do
    donor = Donor.create(name: "Example Donor", email: "example@example.com")
    assert_difference('Donor.count', -1) do
      delete :destroy, params: { id: donor.id }
    end
    assert_response :success
  end
end
