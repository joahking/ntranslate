class TextResource < ActiveRecord::Base
  attr_accessible :key, :project_id

  belongs_to :project
end
