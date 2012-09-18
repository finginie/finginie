class AddMoreFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favourite_stocks, :string
    add_column :users, :investing_style, :string
  end
end
