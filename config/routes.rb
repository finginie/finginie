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

  root :to => 'portfolios#index'

end
