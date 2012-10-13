class Project < ActiveRecord::Base
  attr_accessible :name, :languages, :master_language

  has_many :text_resources
  has_many :user_projects, :dependent => :destroy
  has_many :users, :through => :user_projects

  serialize :languages

  validates :name, :presence => true
  validates :languages, :presence => true

  before_save :clean_languages

private

  def clean_languages
    languages.delete_if(&:blank?)
  end

end
