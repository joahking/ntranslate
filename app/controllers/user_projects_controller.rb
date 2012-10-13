class UserProjectsController < ApplicationController
  before_filter :find_user
  before_filter :find_projects, :only => [:edit, :update]

  def index
    @user_projects = UserProject.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def edit
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def update
    @user.refresh_projects params[:projects_ids]

    respond_to do |format|
      format.html { redirect_to @user, notice: 'Projects successfully assigned.' }
    end
  end

  protected

  def find_user
    @user = User.find params[:user_id], :include => :projects
  end

  def find_projects
    @projects = Project.all
  end
end
