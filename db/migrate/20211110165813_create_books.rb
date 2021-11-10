class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false, limit: 255
      t.string :subtitle, limit: 255
      t.integer :position

      t.belongs_to :edition

      t.timestamps
    end
  end
end
