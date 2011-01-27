require 'test_helper'

class VisaApplicationsControllerTest < ActionController::TestCase
  setup do
    @visa_application = visa_applications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:visa_applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create visa_application" do
    assert_difference('VisaApplication.count') do
      post :create, :visa_application => @visa_application.attributes
    end

    assert_redirected_to visa_application_path(assigns(:visa_application))
  end

  test "should show visa_application" do
    get :show, :id => @visa_application.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @visa_application.to_param
    assert_response :success
  end

  test "should update visa_application" do
    put :update, :id => @visa_application.to_param, :visa_application => @visa_application.attributes
    assert_redirected_to visa_application_path(assigns(:visa_application))
  end

  test "should destroy visa_application" do
    assert_difference('VisaApplication.count', -1) do
      delete :destroy, :id => @visa_application.to_param
    end

    assert_redirected_to visa_applications_path
  end
end
