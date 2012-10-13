class Translation < ActiveRecord::Base
  attr_accessible :content, :language_id, :text_resource_id, :language

  belongs_to :text_resource
end
