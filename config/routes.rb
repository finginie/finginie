Finginie::Application.routes.draw do

  match "/signin" => "sessions#new", :as => :signin
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout

  resources :profiles, :only => [:index, :show]
  resource  :profile,  :only => [:show, :edit, :update], :as => :own_profile

  resources :subscriptions, :only => [:index, :create, :destroy]

  resources :other_assets
  resources :other_liabilities
  resources :loans
  resources :fixed_incomes
  resources :real_estates
  resources :stocks, :only => [:index, :show]

  resources :portfolios do
    resources :transactions, :only => [:index]
    resources :net_positions, :except => :index do
      resources :transactions, :except => [:index, :show]
    end
  end

  resource :financial_planner, :only => [:show, :update], :controller => :financial_planner do
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
