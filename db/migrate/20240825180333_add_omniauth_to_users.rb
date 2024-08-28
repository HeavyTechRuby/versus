class AddOmniauthToUsers < ActiveRecord::Migration[7.1]
  def up
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string
    change_column :users, :username, :string, null: false
    add_index :users, :username, unique: true
  end

  def down
    remove_column :users, :provider
    remove_column :users, :uid
    remove_column :users, :name
    change_column :users, :username, :string, null: true
    remove_index :users, :username
  end
end
