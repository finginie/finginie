require 'spec_helper'

describe TransactionsController do

  let(:user_session) {
    session[:user_id] = create(:user).id
  }

  let(:portfolio) { create :portfolio, :user_id => user_session }
  let(:transaction) { create :transaction, :quantity => 100, :price => 10, :net_position => create(:net_position, :portfolio => portfolio) }

  let(:build_transaction) {
    attributes_for :transaction
  }

  describe "DELETE 'destroy'" do
    it "should be redirect" do
      delete 'destroy', :id => transaction.id, :net_position_id => transaction.id, :portfolio_id => portfolio.id
      response.should redirect_to(portfolio_path(portfolio.id))
    end
  end

  describe "PUT 'update'" do
    it "should be redirect" do
      put 'update', :id => transaction.id, :net_position_id => transaction.net_position_id, :portfolio_id => portfolio.id
      response.should redirect_to(portfolio_path(portfolio.id))
    end
  end

  describe "POST 'create'" do
    it "should be redirect" do
      post 'create', :transaction => build_transaction, :net_position_id => transaction.net_position_id, :portfolio_id => transaction.net_position.portfolio_id
      response.should redirect_to(portfolio_path(portfolio.id))
    end
  end
end
