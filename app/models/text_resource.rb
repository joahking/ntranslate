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
    master_translation.content = @content if @content
  end

  def master_translation
    master_language = project.master_language
    translation = self.translations.detect { |x| x.language = master_language }
    translation ||= self.translations.find_or_initialize_by_language(master_language)
  end

end
