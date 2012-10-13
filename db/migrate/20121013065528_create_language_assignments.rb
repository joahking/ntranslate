class CreateLanguageAssignments < ActiveRecord::Migration
  def change
    create_table :language_assignments do |t|
      t.integer :project_id
      t.integer :language_id
      t.integer :master_language_id
    end
    add_index :language_assignments, :project_id
  end
end
