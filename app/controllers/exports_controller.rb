require 'zip/zip'

class ExportsController < ApplicationController
  before_filter :find_project

  respond_to :json, :yaml

  def index
    respond_to do |format|
      format.json { render :json => project_as_json }
      format.yaml { send_data project_as_yml, :filename => "#{@project.name}.zip" }
    end
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_as_json
    project_hash.as_json
  end

  def project_as_yml
    stringio = Zip::ZipOutputStream::write_buffer do |zio|
      project_hash.each do |lang, content|
        zio.put_next_entry("#{lang}.yml")
        zio.write YAML::dump({ lang => content} )
      end
    end
    stringio.rewind
    stringio.sysread
  end

  def project_hash
    project = {}

    @project.languages.each do |lang|
      lang_content = {}
      @project.text_resources.each do |text_resource|
        contents = text_resource.key.split(".")
        content = text_resource.content_for(lang)
        content = content.split("\n") if text_resource.array?
        contents = contents.reverse.inject(content) { |a, n| { n => a } }
        lang_content.deep_merge!(contents)
      end
      project[lang] = lang_content
    end

    project
  end

end
