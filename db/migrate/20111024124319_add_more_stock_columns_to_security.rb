class AddMoreStockColumnsToSecurity < ActiveRecord::Migration
  def change
    change_table :securities do |t|
      t.string  :sector
      t.decimal :beta
      t.integer :pe
      t.integer :eps
      t.decimal :last_close_price
      t.decimal :day_change
      t.decimal :day_open_price
      t.string  :symbol
      t.string  :asset_class
      t.decimal :fifty_two_week_high_price
      t.decimal :fifty_two_week_low_price
      t.date    :fifty_two_week_high_date
      t.date    :fifty_two_week_low_date
    end
  end
end
