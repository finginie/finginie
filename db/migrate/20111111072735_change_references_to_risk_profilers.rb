class ChangeReferencesToRiskProfilers < ActiveRecord::Migration
  class RiskProfiler < ActiveRecord::Base
  end

  class FinancialPlanner < ActiveRecord::Base
  end

  def change
    add_column :risk_profilers, :financial_planner_id, :int
    add_index  :risk_profilers, :financial_planner_id

    RiskProfiler.all.each { |r| r.financial_planner_id = FinancialPlanner.find_or_create_by_user_id(r.user_id).id }

    remove_column :risk_profilers, :user_id
  end

end
