class RemoveFinancialPlanner < ActiveRecord::Migration
  def up
    drop_table :financial_planners
  end

  def down
    create_table :financial_planners do |t|
      t.references :user
      t.decimal :willingness_to_take_risk

      t.timestamps
    end

    add_index :financial_planners, :user_id
  end
end
