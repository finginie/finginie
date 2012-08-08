class CreateTradeAccounts < ActiveRecord::Migration
  def change
    create_table :trade_accounts do |t|
      t.references :user
      t.string :name
      t.string :phone_number
      t.text :address
      t.string :city
      t.text :special_requirements
      t.boolean :issued

      t.timestamps
    end
    add_index :trade_accounts, :user_id
  end
end
