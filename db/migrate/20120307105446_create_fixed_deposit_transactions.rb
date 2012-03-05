class CreateFixedDepositTransactions < ActiveRecord::Migration
  def change
    create_table :fixed_deposit_transactions do |t|
      t.decimal :price
      t.date :date
      t.text :comments
      t.references :portfolio
      t.references :fixed_deposit

      t.timestamps
    end
    add_index :fixed_deposit_transactions, :portfolio_id
    add_index :fixed_deposit_transactions, :fixed_deposit_id
  end
end
