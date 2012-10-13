class TextResource < ActiveRecord::Base
  include TranslationMethods

  attr_accessible :key, :project_id, :content

  belongs_to :project

  puret :content

  attr_translated :content

  delegate :master_language, :to => :project

  def original_content
    content_for(master_language)
  end
end
