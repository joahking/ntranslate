class Language < ActiveRecord::Base
  attr_accessible :iso_code, :name

  def self.ordered
    order("name ASC")
  end
end
