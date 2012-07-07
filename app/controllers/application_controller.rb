class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json
  include OmniauthSingleSignon::ApplicationHelper

  rescue_from CanCan::AccessDenied do |exception|
    current_user ? redirect_back_with(exception) : redirect_to_login
  end

  def redirect_to_login
    session[:user_return_to] = request.fullpath
    redirect_to main_app.signin_path
  end

  def redirect_back_with(exception)
    begin
      redirect_to :back, :alert => exception.message
    rescue ActionController::RedirectBackError
      redirect_to :root, :alert => exception.message
    end
  end

  helper OmniauthSingleSignon::ApplicationHelper

  helper_method :auto_page_class_names

private
  def auto_page_class_names
    [params[:controller], params[:action], params[:id]].compact.map{ |n| n.split('/') }.flatten
  end
end
