class ChangeLanguageColumnOnTranslations < ActiveRecord::Migration
  def up
    remove_column :translations, :language_id
    add_column :translations, :language, :string
  end

  def down
    add_column :translations, :language_id, :integer
    remove_column :translations, :language
  end
end
