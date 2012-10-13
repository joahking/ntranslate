class UserProject < ActiveRecord::Base
  attr_accessible :project, :user
  belongs_to :project
  belongs_to :user
  validates :project, :user, :presence => true
end
