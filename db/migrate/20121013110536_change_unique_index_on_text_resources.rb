class ChangeUniqueIndexOnTextResources < ActiveRecord::Migration
  def up
    remove_index :text_resources, [:key]
    remove_index :text_resources, [:project_id]
    add_index :text_resources, [:project_id, :key], :unique => true
  end

  def down
    add_index :text_resources, [:key]
    add_index :text_resources, [:project_id]
    remove_index :text_resources, [:project_id, :key]
  end
end
