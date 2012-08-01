class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json
  include OmniauthSingleSignon::ApplicationHelper

  rescue_from CanCan::AccessDenied do |exception|
    current_user ? redirect_back_with(exception) : redirect_to_login
  end

  def redirect_to_login
    redirect_to login_and_go_to(request.fullpath)
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
  helper_method :login_and_go_to
  helper_method :single_signon_path

private
  def auto_page_class_names
    [params[:controller], params[:action], params[:id]].compact.map{ |n| n.split('/') }.flatten
  end

  def login_and_go_to(origin = main_app.root_path)
    main_app.signin_path(:origin => origin)
  end

  def single_signon_path(origin)
    "/auth/single_signon?origin=#{origin}"
  end
end
