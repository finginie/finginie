class FinancialPlannerController < InheritedResources::Base
  actions :show, :update
  def resource
    @financial_planner = FinancialPlanner.find_or_create_by_user_id(current_user.id).build_risk_profilers
  end
end
