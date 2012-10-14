class TextResourcesController < ApplicationController
  before_filter :authorize
  before_filter :find_project

  # GET /text_resources
  # GET /text_resources.json
  def index
    @text_resources = @project.text_resources

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @text_resources }
    end
  end

  # GET /text_resources/1
  # GET /text_resources/1.json
  def show
    @text_resource = @project.text_resources.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @text_resource }
    end
  end

  # GET /text_resources/new
  # GET /text_resources/new.json
  def new
    @text_resource = @project.text_resources.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @text_resource }
    end
  end

  # GET /text_resources/1/edit
  def edit
    @text_resource = @project.text_resources.find(params[:id])
  end

  # POST /text_resources
  # POST /text_resources.json
  def create
    @text_resource = @project.text_resources.build(params[:text_resource])

    respond_to do |format|
      if @text_resource.save
        format.html { redirect_to project_text_resources_path(@project), notice: 'Text resource was successfully created.' }
        format.json { render json: @text_resource, status: :created, location: @text_resource }
      else
        format.html { render action: "new" }
        format.json { render json: @text_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /text_resources/1
  # PUT /text_resources/1.json
  def update
    @text_resource = TextResource.find(params[:id])

    respond_to do |format|
      if @text_resource.update_attributes(params[:text_resource])
        format.html { redirect_to project_text_resources_path(@project), notice: 'Text resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @text_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /text_resources/1
  # DELETE /text_resources/1.json
  def destroy
    @text_resource = TextResource.find(params[:id])
    @text_resource.destroy

    respond_to do |format|
      format.html { redirect_to project_text_resources_path(@project) }
      format.json { head :no_content }
    end
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def authorize
    authorize! :manage, TextResource
  end

end
