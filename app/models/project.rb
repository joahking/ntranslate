class Project < ActiveRecord::Base
  attr_accessible :name, :languages, :master_language

  has_many :text_resources
  has_many :user_projects, :dependent => :destroy
  has_many :users, :through => :user_projects

  serialize :languages

  validates :name, :presence => true, :format => { :with => /\A[a-zA-Z0-9\-_]+\z/, :message => "Only letters, numbers, - and _ are allowed" }
  validates :languages, :master_language, :presence => true
  validate :languages_contain_master_language

  before_save :clean_languages

  def text_resources_count
    text_resources.count
  end

  def has_pending_translations?(locale)
    pending_translations_count(locale) > 0
  end

  def pending_translations_count(locale)
    locale == master_language ? 0 : text_resources.pending_translation(locale).count
  end

  def languages_without_master
    languages - [master_language]
  end

  def to_param
    "#{id}-#{name.downcase}"
  end

  def languages_records
    Language.where("iso_code in (?)", languages)
  end

private

  def clean_languages
    languages.delete_if(&:blank?)
  end

  def languages_contain_master_language
    if languages.exclude? master_language
      errors.add(:master_language, "Should be one of the languages")
    end
  end
end
