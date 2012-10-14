class AddArrayToTextResources < ActiveRecord::Migration
  def change
    add_column :text_resources, :array, :boolean, :default => false
  end
end
