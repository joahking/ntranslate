class TextResourceTranslation < ActiveRecord::Base
  attr_accessible :id, :text_resource_id, :content, :created_at, :updated_at, :locale, :translated

  puret_for :text_resource
end
