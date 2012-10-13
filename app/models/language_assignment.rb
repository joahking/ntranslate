class LanguageAssignment < ActiveRecord::Base
  attr_accessible :language_id, :master_language_id, :project_id, :language

  belongs_to :project
  belongs_to :language
  belongs_to :master_language, :class_name => "Language"
end
