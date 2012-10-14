class ImportsController < ApplicationController
  before_filter :find_project
  before_filter :set_text_resources_tab

  def index
  end

  def upload
    begin
      file = params[:project][:file].tempfile
      TextResourceImporter.import_yaml_file_into_project(file, @project)
      flash[:notice] = "File successfully imported"
    rescue
      flash[:error] = "File import failed"
      redirect_to import_project_path(@project) and return
    end
    redirect_to project_text_resources_path(@project)
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

end
