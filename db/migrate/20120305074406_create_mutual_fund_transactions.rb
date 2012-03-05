class CreateMutualFundTransactions < ActiveRecord::Migration
  def change
    create_table :mutual_fund_transactions do |t|
      t.decimal :price
      t.date :date
      t.integer :quantity
      t.text :comments
      t.references :portfolio
      t.references :mutual_fund

      t.timestamps
    end
    add_index :mutual_fund_transactions, :portfolio_id
    add_index :mutual_fund_transactions, :mutual_fund_id
  end
end
