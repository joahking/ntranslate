class Project < ActiveRecord::Base
  attr_accessible :name

  has_many :language_assignments
  has_many :languages, :through => :language_assignments
end
