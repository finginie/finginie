Finginie::Application.routes.draw do

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

  mount ClearanceOmniauth::Engine => "/auth"

  root :to => 'portfolios#index'

end
