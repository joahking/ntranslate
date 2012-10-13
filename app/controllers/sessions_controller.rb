class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    unless @identity = Identity.find_from_hash(auth_hash)
      @identity = Identity.create_from_hash(auth_hash, current_user)
    end
    self.current_user = @identity.user
    redirect_to root_path, :notice => "Signed in!"
  end

  def destroy
    @current_user = session[:user_id] = nil #TODO does this line belongs to application_controller?
    redirect_to root_path, :notice => "Signed out!"
  end
end
