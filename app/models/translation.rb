class Translation < ActiveRecord::Base
  attr_accessible :content, :language_id, :text_resource_id

  belongs_to :text_resource
  belongs_to :language
end