class ChangeTranslations < ActiveRecord::Migration
  def up
    rename_table :translations, :text_resource_translations
    rename_column :text_resource_translations, :language, :locale
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
