class TranslationsController < ApplicationController
  before_filter :find_project

  def index
    @text_resource =
      if params[:text_resource_id]
        @project.text_resources.find(params[:id])
      else
        #TODO it should be actually first one not translated
        @project.text_resources.first
      end
  end

  def create
    @text_resource = @project.text_resources.find(params[:text_resource].delete(:id))
    if @text_resource.update_attributes(params[:text_resource])
      redirect_to translations_url(@project, params[:locale]), :notice => "Saved translation!"
    else
      render :index
    end
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end
end
