class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, limit: 255, index: { unique: true }

      t.timestamps
    end
  end
end
