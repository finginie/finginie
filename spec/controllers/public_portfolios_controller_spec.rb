require 'spec_helper'

describe PublicPortfoliosController do
  describe "POST 'create'" do
    let(:portfolio) { create :portfolio }
    it 'should make portfolio public' do
      Portfolio.stub(:find).and_return(portfolio)
      portfolio.should_receive :make_public!
      post :create, :id => portfolio.id
    end
  end
end
