class AddProfileToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :avatar_url, :string
    add_column :users, :location, :string
    add_column :users, :occupation, :string
    add_column :users, :company, :string
  end
end
