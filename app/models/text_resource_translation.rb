class TextResourceTranslation < ActiveRecord::Base
  attr_accessible :id, :text_resource_id, :content, :created_at, :updated_at, :locale, :translated

  puret_for :text_resource

  before_save :init_translated

private

  def init_translated
    self.translated = true if locale == text_resource.project.master_language
  end

end
