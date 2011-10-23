Finginie::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :other_assets
  resources :other_liabilities
  resources :loans
  resources :fixed_incomes
  resources :real_estates
  resources :stocks

  resources :portfolios do
    resources :net_positions, :except => :index do
      resources :transactions, :except => [:index, :show]
    end
  end

  resource :financial_planner, :only => :show, :controller => :financial_planner do
    resources :risk_profilers, :only => [:show, :update]
  end

  def controller_actions(controller, actions)
    match "#{controller}(/:action)", :controller => controller, :as => controller
    actions.each do |action|
      match "#{controller}/#{action}", :as => action
    end
  end

  controller_actions 'personal_financial_tools', %w[emi_calculators fixed_deposit_calculators income_tax_calculator life_insurance_calculators monthly_sip_calculator rate_of_return_calculator recurring_deposit_calculator retirement_corpus_calculator sip_calculator]

  root :to => 'pages#show', :id => 'home'

end
