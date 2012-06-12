Finginie::Application.routes.draw do

  resources "fixed-deposits", :controller => :fixed_deposits, :as => :fixed_deposits, :only => [:index]

  match "/signin" => "sessions#new", :as => :signin
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout

  resources :profiles, :only => [:index, :show]
  resource  :profile,  :only => [:show, :edit, :update], :as => :own_profile

  resources :subscriptions, :only => [:index, :create, :destroy]

  resources :mutual_funds, :only => [:index, :show] do
    member do
      get 'scheme_returns'
      get 'top_holdings'
      get 'detailed_holdings'
      get 'asset_allocation'
      get 'sectoral_allocation'
    end
  end

  resources :mutual_fund_categories, :only => [:show]
  resources :other_assets
  resources :other_liabilities
  resources :loans
  resources :fixed_incomes
  resources :real_estates
  resources "shares", :controller => :stocks, :as => :stocks, :only => [:index, :show], :constraints => { :id => /.*/ } do
    collection do
      get 'screener'
    end
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
      get 'stocks_analysis'
      get 'mutual_funds_analysis'
      get 'fixed_deposits_analysis'
      get 'accumulated_profits'
      get 'add_transaction'
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
  end

  mount PersonalFinancialTools::Engine => "/personal_financial_tools"

  root :to => 'pages#show', :id => 'home'

end
