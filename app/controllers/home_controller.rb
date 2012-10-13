class HomeController < ApplicationController
  skip_before_filter :authenticate

  def index
    @users = User.all
  end
end
