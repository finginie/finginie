class CreateSecurities < ActiveRecord::Migration
  def change
    create_table :securities do |t|
      t.string :type
      t.string :name
      t.references :user
      t.decimal :current_price
      t.decimal :period
      t.decimal :rate_of_interest
      t.text :location
      t.decimal :emi

      t.timestamps
    end
    add_index :securities, :user_id
  end
end
