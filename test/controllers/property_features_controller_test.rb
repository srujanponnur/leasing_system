require "test_helper"

class PropertyFeaturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @property_feature = property_features(:one)
  end

  test "should get index" do
    get property_features_url
    assert_response :success
  end

  test "should get new" do
    get new_property_feature_url
    assert_response :success
  end

  test "should create property_feature" do
    assert_difference('PropertyFeature.count') do
      post property_features_url, params: { property_feature: { are_pets_allowed: @property_feature.are_pets_allowed, in_unit_laundry: @property_feature.in_unit_laundry, parking: @property_feature.parking } }
    end

    assert_redirected_to property_feature_url(PropertyFeature.last)
  end

  test "should show property_feature" do
    get property_feature_url(@property_feature)
    assert_response :success
  end

  test "should get edit" do
    get edit_property_feature_url(@property_feature)
    assert_response :success
  end

  test "should update property_feature" do
    patch property_feature_url(@property_feature), params: { property_feature: { are_pets_allowed: @property_feature.are_pets_allowed, in_unit_laundry: @property_feature.in_unit_laundry, parking: @property_feature.parking } }
    assert_redirected_to property_feature_url(@property_feature)
  end

  test "should destroy property_feature" do
    assert_difference('PropertyFeature.count', -1) do
      delete property_feature_url(@property_feature)
    end

    assert_redirected_to property_features_url
  end
end
