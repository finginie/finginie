class CreateNetPositions < ActiveRecord::Migration
  def change
    create_table :net_positions do |t|
      t.references :portfolio
      t.references :security

      t.timestamps
    end
    add_index :net_positions, :portfolio_id
    add_index :net_positions, :security_id
  end
end
