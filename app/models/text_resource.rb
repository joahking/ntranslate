class TextResource < ActiveRecord::Base
  include TranslationMethods

  attr_accessible :key, :project_id, :content, :original_content

  belongs_to :project

  puret :content

  attr_translated :content

  validates :key, :presence => true

  validates :original_content, :presence => true

  delegate :master_language, :to => :project

  scope :pending_translation, lambda { |language|
    joins("LEFT OUTER JOIN text_resource_translations ON text_resources.id = text_resource_translations.text_resource_id AND text_resource_translations.locale = '#{language}'").
    where("translated = ? OR text_resource_translations.text_resource_id IS NULL", false)
  }

  def original_content
    content_for(master_language)
  end

  def original_content=(value)
    self.send(:"content_#{master_language}=", value)
  end

  after_save :expire

  # TODO: Fix this monkey path (Fork puret)
  alias_method :orig_content=, :content=

  def content=(value)
    changed_languages << I18n.locale.to_s
    self.orig_content = value
  end

  def expire
    if changed_languages.include?(master_language)
      translations.select {|x| x.locale != master_language }.each do |t|
        t.update_attribute(:translated, false)
      end
    end
    changed_languages.each do |language|
      translation = translations.detect { |t| t.locale == language }
      translation.update_attribute(:translated, true)
    end
  end

  def changed_languages
    @changed_languages ||= []
  end

end
