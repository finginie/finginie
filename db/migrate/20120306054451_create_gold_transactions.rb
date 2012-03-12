class CreateGoldTransactions < ActiveRecord::Migration
  def change
    create_table :gold_transactions do |t|
      t.decimal :price
      t.date :date
      t.integer :quantity
      t.text :comments
      t.references :portfolio
      t.references :gold

      t.timestamps
    end
    add_index :gold_transactions, :portfolio_id
    add_index :gold_transactions, :gold_id
  end
end
