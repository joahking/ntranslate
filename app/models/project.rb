class Project < ActiveRecord::Base
  attr_accessible :name, :language_ids

  has_many :language_assignments
  has_many :languages, :through => :language_assignments
  has_many :text_resources

  after_save :set_master_language, :on => :create

  validates :name, :presence => true
  validates :languages, :presence => true

  private

  def set_master_language
    master_language = self.languages.first
    self.language_assignments.update_all(master_language_id: master_language.id)
  end
end
