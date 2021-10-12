class CreateTexts < ActiveRecord::Migration[6.1]
  def change
    create_table :texts do |t|
      t.integer :nietzsche_number, null:false
      t.integer :kgw_notebook_number, null: false
      t.integer :kgw_text_number, null: false
      t.integer :book_number
      t.integer :duplicate
      t.string :url_slug, null: false
      t.string :title, null: false, limit: 255
      t.text :text, null: false

      t.index :nietzsche_number
      t.index :url_slug, unique: true

      t.timestamps
    end
  end
end
