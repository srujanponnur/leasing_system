require "test_helper"

class PropertiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @property = properties(:one)
  end

  test "should get index" do
    get properties_url
    assert_response :success
  end

  test "should get new" do
    get new_property_url
    assert_response :success
  end

  test "should create property" do
    assert_difference('Property.count') do
      post properties_url, params: { property: { address: "bla bla", application_fee: 123, monthly_rent: 100, name: "ronaldo", size: 100, terms_available: 100 } }
    end

    assert_redirected_to property_url(Property.last)
  end

  test "should show property" do
    get property_url(@property)
    assert_response :success
  end

  test "should get edit" do
    get edit_property_url(@property)
    assert_response :success
  end

  test "should update property" do
    patch property_url(@property), params: { property: { address: "bla bla", application_fee: 123, monthly_rent: 100, name: "ronaldo", size: 100, terms_available: 100 } }
    assert_redirected_to property_url(@property)
  end

  test "should destroy property" do
    assert_difference('Property.count', -1) do
      delete property_url(@property)
    end

    assert_redirected_to properties_url
  end

  test "should not create property with null values" do
    post properties_url, params: { property: { } }
    assert_response :error
  end

  test "should not create property with just negative application fee" do
    post properties_url, params: { property: { address: "bla bla", application_fee: -123, monthly_rent: 100, name: "ronaldo", size: 100, terms_available: 100 } }
    assert_response :error
  end

  test "should not create property with null address only" do 
    post properties_url, params: { property: { application_fee: -123, monthly_rent: 100, name: "ronaldo", size: 100, terms_available: 100 } }
    assert_response :error
  end

  test "should not create property with null name only" do 
    post properties_url, params: { property: { application_fee: -123, monthly_rent: 100, size: 100, terms_available: 100 } }
    assert_response :error
  end

  test "should not create property with null size only" do 
    post properties_url, params: { property: { application_fee: -123, monthly_rent: 100, size: -100, terms_available: 100 } }
    assert_response :error
  end

  test "should not create property with negative rent only" do 
    post properties_url, params: { property: { application_fee: -123, monthly_rent: -100, size: -100, terms_available: 100 } }
    assert_response :error
  end

  test "should not create property with negative terms available only" do 
    post properties_url, params: { property: { application_fee: -123, terms_available: -100 } }
    assert_response :error
  end

  test "should not create property with null size only" do 
    post properties_url, params: { property: { application_fee: -123, monthly_rent: 100, terms_available: 100 } }
    assert_response :error
  end

  test "should not create property with just null application fee" do
    post properties_url, params: { property: { address: "bla bla", application_fee: 123, name: "ronaldo", size: 100, terms_available: 100 } }
    assert_response :error
  end
end
