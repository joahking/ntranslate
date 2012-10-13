class CreateTextResources < ActiveRecord::Migration
  def change
    create_table :text_resources do |t|
      t.integer :project_id
      t.string :key, :unique => true
      t.timestamps
    end
    add_index :text_resources, :project_id
    add_index :text_resources, :key, :unique => true
  end
end
