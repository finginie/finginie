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
    resources :net_positions do
      resources :transactions
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

  controller_actions 'personal_financial_tools', %w[emi_calculators income_tax_calculator]


  root :to => 'portfolios#index'

end
