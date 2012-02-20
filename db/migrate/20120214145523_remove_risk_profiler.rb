class RemoveRiskProfiler < ActiveRecord::Migration
  def up
    drop_table :risk_profilers
  end

  def down
    create_table :risk_profilers do |t|
      t.references :quiz
      t.references :financial_planner
      t.decimal :score

      t.timestamps
    end

    add_index :risk_profilers, :quiz_id
    add_index :risk_profilers, :financial_planner_id
  end
end
