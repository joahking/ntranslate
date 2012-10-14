class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  before_filter :authenticate
  before_filter :set_tabs

protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  helper_method :current_user, :signed_in?

  def current_user=(user)
    @current_user     = user
    session[:user_id] = user.id
  end

  def authenticate
    unless signed_in?
      redirect_to home_path
    end
  end

  def set_tabs
    set_tab controller_name
  end

  def set_text_resources_tab
    set_tab "text_resources"
  end
end
