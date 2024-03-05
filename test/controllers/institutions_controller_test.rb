require 'test_helper'

class InstitutionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should show institution" do
    institution = Institution.create(name: "Example Institution", cnpj: "12345678901234", bank_account: "123456")
    get :show, params: { id: institution.id }
    assert_response :success
  end

  test "should create institution" do
    assert_difference('Institution.count') do
      post :create, params: { institution: { name: "New Institution", cnpj: "98765432109876", bank_account: "654321" } }
    end
    assert_response :success
  end

  test "should update institution" do
    institution = Institution.create(name: "Example Institution", cnpj: "12345678901234", bank_account: "123456")
    put :update, params: { id: institution.id, institution: { name: "Updated Institution" } }
    institution.reload
    assert_equal "Updated Institution", institution.name
    assert_response :success
  end

  test "should destroy institution" do
    institution = Institution.create(name: "Example Institution", cnpj: "12345678901234", bank_account: "123456")
    assert_difference('Institution.count', -1) do
      delete :destroy, params: { id: institution.id }
    end
    assert_response :success
  end

end
