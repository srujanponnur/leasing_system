class ApplicationController < ActionController::Base
  before_action :authorized
  helper_method :current_user
  helper_method :check_permissions?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def authorized
    if current_user.nil?
      redirect_to root_path
    end
     # unless current_user.nil?
  end

  def find_user_type_object(user_type)
      if user_type == "applicant"
        return Applicant
      elsif user_type == "leasing_agent"
        return LeasingAgent
      elsif user_type == "admin"
        return Admin
      else
        return nil
      end
  end

  def check_permissions?(user_type, action)
    @actions = {"leasing_agent" => ['create_property', 'delete_property', 'accept_application', 'reject_application',
      'checkin_applicant', 'checkout_applicant', 'update_property', 'add_property_feature', 'edit_property'],
      "admin" => ['create_property', 'delete_property', 'accept_application', 'reject_application', 'checkin_applicant', 
      'checkout_applicant', 'update_property', 'add_property_feature', 'edit_property', 'create_leasing_agent', 
      'delete_leasing_agent', 'delete_application', 'delete_applicant', 'delete_leasing_agent', 'create_leasing_agent', 'create_admin',
      'withdraw_application', 'create_application', 'view_applicants', 'edit_applicant'],
      "applicant" => ['withdraw_application', 'create_application', 'edit_applicant']
    }
    if @actions[user_type] && @actions[user_type].include?(action)
      return true
    end
    return false
  end
end
