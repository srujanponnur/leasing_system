require "application_system_test_case"

class PropertyFeaturesTest < ApplicationSystemTestCase
  setup do
    @property_feature = property_features(:one)
  end

  test "visiting the index" do
    visit property_features_url
    assert_selector "h1", text: "Property Features"
  end

  test "creating a Property feature" do
    visit property_features_url
    click_on "New Property Feature"

    check "Are pets allowed" if @property_feature.are_pets_allowed
    check "In unit laundry" if @property_feature.in_unit_laundry
    check "Parking" if @property_feature.parking
    click_on "Create Property feature"

    assert_text "Property feature was successfully created"
    click_on "Back"
  end

  test "updating a Property feature" do
    visit property_features_url
    click_on "Edit", match: :first

    check "Are pets allowed" if @property_feature.are_pets_allowed
    check "In unit laundry" if @property_feature.in_unit_laundry
    check "Parking" if @property_feature.parking
    click_on "Update Property feature"

    assert_text "Property feature was successfully updated"
    click_on "Back"
  end

  test "destroying a Property feature" do
    visit property_features_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Property feature was successfully destroyed"
  end
end
