class DropLanguageAssignments < ActiveRecord::Migration
  def up
    drop_table :language_assignments
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
