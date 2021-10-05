class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user
      specific_user_class = find_user_type_object(user.user_type)
      specific_user_object = specific_user_class.find_by_user_id(user.id)
      if specific_user_object.authenticate(params[:password])
        session[:user_id] = user.id
        session[:user_type] = user.user_type
        redirect_to root_url
      else
        flash.now[:alert] = "Email or password is invalid"
        render "new"
      end
    else
      flash.now[:alert] = "No user found"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
