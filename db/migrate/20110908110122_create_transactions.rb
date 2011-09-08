class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :net_position
      t.decimal :price
      t.date :date
      t.integer :quantity
      t.text :comments

      t.timestamps
    end
    add_index :transactions, :net_position_id
  end
end
