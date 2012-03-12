class CreateLoanTransactions < ActiveRecord::Migration
  def change
    create_table :loan_transactions do |t|
      t.decimal :price
      t.date :date
      t.text :comments
      t.references :portfolio
      t.references :loan

      t.timestamps
    end
    add_index :loan_transactions, :portfolio_id
    add_index :loan_transactions, :loan_id
  end
end
