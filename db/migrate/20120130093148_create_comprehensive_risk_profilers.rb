class CreateComprehensiveRiskProfilers < ActiveRecord::Migration
  def change
    create_table :comprehensive_risk_profilers do |t|
      t.references :user
      t.integer :age
      t.integer :household_savings
      t.integer :household_income
      t.integer :dependent
      t.integer :household_expenditure
      t.integer :special_goals_amount
      t.integer :special_goals_years
      t.integer :tax_saving_investment
      t.integer :preference
      t.integer :portfolio_investment
      t.integer :time_horizon

      t.decimal :score_cache

      t.timestamps
    end
    add_index :comprehensive_risk_profilers, :user_id
  end
end
