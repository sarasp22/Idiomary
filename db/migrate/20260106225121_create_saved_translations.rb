class CreateSavedTranslations < ActiveRecord::Migration[7.1]
  def change
    create_table :saved_translations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :original_idiom
      t.string :source_language
      t.string :target_language
      t.text :ai_response

      t.timestamps
    end
  end
end
