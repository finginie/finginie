class ChangeComprehensiveRiskProfilerColumnType < ActiveRecord::Migration
  def change
    change_table(:comprehensive_risk_profilers) do |t|
      t.change :age, :decimal
      t.change :household_savings, :decimal
      t.change :household_income, :decimal
      t.change :household_expenditure, :decimal
      t.change :special_goals_amount, :decimal
      t.change :special_goals_years, :decimal
      t.change :tax_saving_investment, :decimal
      t.change :time_horizon, :decimal
    end
  end
end
