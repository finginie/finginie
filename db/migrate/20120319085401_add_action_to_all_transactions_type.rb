class AddActionToAllTransactionsType < ActiveRecord::Migration
  def change
    add_column :mutual_fund_transactions, :action, :string
    add_column :stock_transactions, :action, :string
    add_column :gold_transactions, :action, :string
    add_column :fixed_deposit_transactions, :action, :string
    add_column :loan_transactions, :action, :string
    add_column :real_estate_transactions, :action, :string
  end
end
