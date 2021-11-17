class ChangeUsersAddNames < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string, limit: 255
    add_column :users, :last_name, :string, limit: 255
  end
end
