class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  before_filter :authenticate

protected

  def current_user
    @current_user ||= User.first
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
      flash[:error] = "You must sign in first!"
      redirect_to root_path
    end
  end

end
