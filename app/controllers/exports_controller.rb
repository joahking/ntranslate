class ExportsController < ApplicationController
  before_filter :find_project

  respond_to :json, :yml

  def index
    respond_to do |format|
      format.json { render :json => project_as_json }
    end
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_as_json
    project_hash.as_json
  end

  def project_hash
    project = {}

    @project.languages.each do |lang|
      lang_content = {}
      @project.text_resources.each do |text_resource|
        contents = text_resource.key.split(".")
        contents = contents.reverse.inject(text_resource.content_for(lang)) { |a, n| { n => a } }
        lang_content.deep_merge!(contents)
      end
      project[lang] = lang_content
    end

    project
  end

end
