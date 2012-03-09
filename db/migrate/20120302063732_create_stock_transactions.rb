class CreateStockTransactions < ActiveRecord::Migration
  def change
    create_table :stock_transactions do |t|
      t.integer :quantity
      t.decimal :price
      t.date :date
      t.text :comments
      t.references :portfolio
      t.references :stock

      t.timestamps
    end
    add_index :stock_transactions, :portfolio_id
    add_index :stock_transactions, :stock_id
  end
end
