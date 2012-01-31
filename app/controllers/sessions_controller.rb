class SessionsController < ApplicationController
  def create
    session[:user_id] = User.find_or_create_by_omniauth request.env["omniauth.auth"]
    redirect_to (session[:user_return_to] || root_path), :notice => "Successfully signed in"
  end

  def destroy
  end
end
