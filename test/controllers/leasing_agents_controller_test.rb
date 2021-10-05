require "test_helper"

class LeasingAgentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @leasing_agent = leasing_agents(:one)
  end

  test "should get index" do
    get leasing_agents_url
    assert_response :success
  end

  test "should get new" do
    get new_leasing_agent_url
    assert_response :success
  end

  test "should create leasing_agent" do
    assert_difference('LeasingAgent.count') do
      post leasing_agents_url, params: { leasing_agent: { name: @leasing_agent.name, password: @leasing_agent.password, phone_number: @leasing_agent.phone_number } }
    end

    assert_redirected_to leasing_agent_url(LeasingAgent.last)
  end

  test "should show leasing_agent" do
    get leasing_agent_url(@leasing_agent)
    assert_response :success
  end

  test "should get edit" do
    get edit_leasing_agent_url(@leasing_agent)
    assert_response :success
  end

  test "should update leasing_agent" do
    patch leasing_agent_url(@leasing_agent), params: { leasing_agent: { name: @leasing_agent.name, password: @leasing_agent.password, phone_number: @leasing_agent.phone_number } }
    assert_redirected_to leasing_agent_url(@leasing_agent)
  end

  test "should destroy leasing_agent" do
    assert_difference('LeasingAgent.count', -1) do
      delete leasing_agent_url(@leasing_agent)
    end

    assert_redirected_to leasing_agents_url
  end
end
