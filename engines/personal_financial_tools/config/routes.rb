PersonalFinancialTools::Engine.routes.draw do

  def controller_actions(controller, actions)
    match "#{controller}(/:action)", :controller => controller, :as => controller
    actions.each do |action|
      match "#{action}", :controller => controller, :as => action
    end
  end
  controller_actions 'personal_financial_tools', %w[emi_calculators fixed_deposit_calculators income_tax_calculator life_insurance_calculators monthly_sip_calculator rate_of_return_calculator recurring_deposit_calculator retirement_corpus_calculator sip_calculator]
  root :to => 'personal_financial_tools#index'

end
