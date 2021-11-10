class CreateEditions < ActiveRecord::Migration[6.1]
  def change
    create_table :editions do |t|
      t.string :title, null: false, limit: 255
      t.string :subtitle, limit: 255

      t.belongs_to :user

      t.timestamps
    end
  end
end
