Finginie::Application.routes.draw do

  match "/signin" => "sessions#new", :as => :signin
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout

  resources :profiles, :only => [:index, :show]
  resource  :profile,  :only => [:show, :edit, :update], :as => :own_profile

  resources :subscriptions, :only => [:index, :create, :destroy]

  resources :mutual_funds, :only => [:index, :show] do
    member do
      get 'scheme_summary'
      get 'scheme_returns'
      get 'top_holdings'
      get 'detailed_holdings'
      get 'asset_allocation'
      get 'sectoral_allocation'
    end
  end

  resources :other_assets
  resources :other_liabilities
  resources :loans
  resources :fixed_incomes
  resources :real_estates
  resources :stocks, :only => [:index, :show] do
    resource :balance_sheet, :only => [:show], :controller => :balance_sheet
    resource :profit_loss, :only => [:show], :controller => :profit_loss
    resource :cash_flow, :only => [:show], :controller => :cash_flow
    resources :news, :only => [:show]
    resource :ratios, :only => [:show]
    resource :share_holding, :only => [:show], :controller => :share_holding
  end

  resource :comprehensive_risk_profiler, :only =>[:edit, :update, :show]

  resources :portfolios do
    member do
      get 'details'
      get 'transactions'
    end
    resources :loan_transactions do
      member do
        post 'clear'
      end
    end
    resources :fixed_deposit_transactions do
      member do
        get 'redeem'
        put 'create_redeem'
      end
    end
    resources :real_estate_transactions do
      member do
        get 'sell'
        put 'create_sell'
      end
    end
    resources :stock_transactions
    resources :mutual_fund_transactions
    resources :gold_transactions
    resources :net_positions, :except => :index do
      resources :transactions, :except => [:index, :show]
    end
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
