class TextResource < ActiveRecord::Base
  include TranslationMethods

  attr_accessible :key, :project_id, :content

  belongs_to :project

  puret :content

  attr_translated :content

  delegate :master_language, :to => :project

  scope :pending_translation, lambda { |language|
    joins("LEFT OUTER JOIN text_resource_translations ON text_resources.id = text_resource_translations.text_resource_id AND text_resource_translations.locale = '#{language}'").
    where("translated = ? OR text_resource_translations.text_resource_id IS NULL", false)
  }

  def original_content
    content_for(master_language)
  end
end
