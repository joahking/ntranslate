class TextResource < ActiveRecord::Base
  attr_accessible :key, :project_id, :content

  attr_accessor :content

  belongs_to :project
  has_many :translations, :autosave => true

  before_save :set_content

  def content
    master_translation.content
  end

  private

  def set_content
    master_translation.content = @content
  end

  def master_translation
    master_language = project.master_language
    translation = self.translations.detect { |x| x.language_id = master_language.id }
    translation ||= find_or_initialize_by_language_id(master_language.id)
  end

end
