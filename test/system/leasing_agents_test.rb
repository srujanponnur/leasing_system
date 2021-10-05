require "application_system_test_case"

class LeasingAgentsTest < ApplicationSystemTestCase
  setup do
    @leasing_agent = leasing_agents(:one)
  end

  test "visiting the index" do
    visit leasing_agents_url
    assert_selector "h1", text: "Leasing Agents"
  end

  test "creating a Leasing agent" do
    visit leasing_agents_url
    click_on "New Leasing Agent"

    fill_in "Name", with: @leasing_agent.name
    fill_in "Password", with: @leasing_agent.password
    fill_in "Phone number", with: @leasing_agent.phone_number
    click_on "Create Leasing agent"

    assert_text "Leasing agent was successfully created"
    click_on "Back"
  end

  test "updating a Leasing agent" do
    visit leasing_agents_url
    click_on "Edit", match: :first

    fill_in "Name", with: @leasing_agent.name
    fill_in "Password", with: @leasing_agent.password
    fill_in "Phone number", with: @leasing_agent.phone_number
    click_on "Update Leasing agent"

    assert_text "Leasing agent was successfully updated"
    click_on "Back"
  end

  test "destroying a Leasing agent" do
    visit leasing_agents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Leasing agent was successfully destroyed"
  end
end
