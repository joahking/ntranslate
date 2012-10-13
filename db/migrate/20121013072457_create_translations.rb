class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.integer :text_resource_id
      t.integer :language_id
      t.text :content
      t.timestamps
    end
    add_index :translations, :text_resource_id
  end
end
