class AddLanguagesToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :master_language, :string
    add_column :projects, :languages, :text
  end
end
