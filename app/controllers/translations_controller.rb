class TranslationsController < ApplicationController
  before_filter :find_project
  before_filter :set_locale
  before_filter :set_text_resources_tab

  def index
    text_resources_to_translate = @project.text_resources.pending_translation(@locale)
    @text_resource = if params[:skip]
                       text_resources_to_translate.where("text_resources.id > ?", params[:skip]).first
                     end
    # if you skipped last one (bigger id), start from the beginning
    @text_resource = text_resources_to_translate.first unless @text_resource

    unless @text_resource
      redirect_to projects_path
    end
  end

  def create
    @text_resource = @project.text_resources.find(params[:text_resource].delete(:id))
    if @text_resource.update_attributes(params[:text_resource])
      redirect_to translations_url(@project, @locale, :skip => @text_resource.id), :notice => "Saved translation!"
    else
      render :index
    end
  end

  def suggestion
    @text_resource = TextResource.find(params[:translation_id])

    respond_to do |format|
      format.js { render :json => { :text => @text_resource.suggestion(@locale) } }
    end
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def set_locale
    @locale = params[:locale]
  end
end
