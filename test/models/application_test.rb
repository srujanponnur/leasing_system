require "test_helper"

class ApplicationTest < ActiveSupport::TestCase
    def "should not create application with null values" do
        @application = Application.new
        assert_not @application.save "cannot create with null values"
    end

    def "should not create application without property" do
        @application = Application.new
        @application.applicant_id = 1
        assert_not @application.save  "cannot be saved without property id"
    end

    def "should not create application without applicant id" do
        @application = Application.new
        @application.property_id = 123
        assert_not @application.save, "applicant id is null"
    end

    def "create application happy flow" do
        @application = Application.new
        @application.property_id = 123
        @application.application_id = 12
        @application.status = "pending"
        assert @application.save 
    end
end
