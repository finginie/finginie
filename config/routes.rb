Finginie::Application.routes.draw do

  resources :other_assets
  resources :other_liabilities
  resources :loans
  resources :fixed_incomes
  resources :real_estates
  resources :stocks

  resources :portfolios do
    resources :net_positions
  end

  mount ClearanceOmniauth::Engine => "/auth"

  root :to => 'portfolios#index'

end
