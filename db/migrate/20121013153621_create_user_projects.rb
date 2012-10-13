class CreateUserProjects < ActiveRecord::Migration
  def change
    create_table :user_projects do |t|
      t.references :user
      t.references :project

      t.timestamps
    end
    add_index :user_projects, [:user_id, :project_id]
  end
end
