require "test_helper"

class ApplicantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @applicant = applicants(:one)
  end

  # test "should get index" do
  #   get applicants_url
  #   assert_response :success
  # end
  #
  # test "should get new" do
  #   get new_applicant_url
  #   assert_response :success
  # end

  test "should create applicant" do
    assert_difference('Applicant.count') do
      post applicants_path, params: { applicant: { id: "3", email: "random", name: "randm", password: "random", phone_number: "124566" } }
    end
    assert_redirected_to login_path
  end

  test "should not create applicant if information is incomplete" do
    assert_no_difference('Applicant.count') do
      post applicants_path, params: { applicant: { id: "3", name: "randm", password: "random", phone_number: "124566" } }
    end
  end

  test "should show applicant" do
    # get login_path, params: {session: {email: @applicant.email, password: @applicant.password}}
    Application.stub!(:authorized).and_return(true)
    get applicant_path(@applicant)
    assert_response :success
  end
  #
  # test "should get edit" do
  #   get edit_applicant_url(@applicant)
  #   assert_response :success
  # end
  #
  # test "should update applicant" do
  #   patch applicant_url(@applicant), params: { applicant: { applicant_id: @applicant.applicant_id, email: @applicant.email, name: @applicant.name, password: @applicant.password, phone_number: @applicant.phone_number } }
  #   assert_redirected_to applicant_url(@applicant)
  # end
  #
  # test "should destroy applicant" do
  #   assert_difference('Applicant.count', -1) do
  #     delete applicant_url(@applicant)
  #   end
  #
  #   assert_redirected_to applicants_url
  # end
end
