require "test_helper"

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @application = applications(:one)
  end

  test "should get index" do
    get applications_url
    assert_response :success
  end

  test "should get new" do
    get new_application_url
    assert_response :success
  end

  test "should create application" do
    assert_difference('Application.count') do
      post applications_url, params: { application: { application_id: @application.application_id, status: @application.status } }
    end

    assert_redirected_to application_url(Application.last)
  end

  test "should show application" do
    get application_url(@application)
    assert_response :success
  end

  test "should get edit" do
    get edit_application_url(@application)
    assert_response :success
  end

  test "should update application" do
    patch application_url(@application), params: { application: { application_id: @application.application_id, status: @application.status } }
    assert_redirected_to application_url(@application)
  end

  test "should destroy application" do
    assert_difference('Application.count', -1) do
      delete application_url(@application)
    end

    assert_redirected_to applications_url
  end

  test "should not create application" do
    assert_not (post applications_url, params: { application: { application_id: @application.application_id } }, "cannot create application without property id")
  end

  test "should not create application with null values" do 
    post applications_url, , params: { application: {  } }, "cannot create application with null values"
    !(assert_response :success) 
  end 
end
