class CreateRealEstateTransactions < ActiveRecord::Migration
  def change
    create_table :real_estate_transactions do |t|
      t.decimal :price
      t.date :date
      t.text :comments
      t.references :portfolio
      t.references :real_estate

      t.timestamps
    end
    add_index :real_estate_transactions, :portfolio_id
    add_index :real_estate_transactions, :real_estate_id
  end
end
