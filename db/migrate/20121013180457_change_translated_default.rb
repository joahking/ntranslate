class ChangeTranslatedDefault < ActiveRecord::Migration
  def up
    change_column :text_resource_translations, :translated, :boolean, :default => true
  end

  def down
    change_column :text_resource_translations, :translated, :boolean, :default => false
  end
end
