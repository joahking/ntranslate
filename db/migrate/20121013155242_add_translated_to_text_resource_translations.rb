class AddTranslatedToTextResourceTranslations < ActiveRecord::Migration
  def change
    add_column :text_resource_translations, :translated, :boolean, :default => false
  end
end
