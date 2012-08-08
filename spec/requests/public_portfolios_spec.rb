require 'spec_helper'

describe 'Portfolios' do
  context 'of a user' do
    include_context 'logged in user'
    let(:portfolio) { create :portfolio, :user => current_user }

    it 'could be shared', :js, :driver => :selenium do
      sleep 5
      visit portfolio_path(portfolio)
      sleep 5
      click_link 'Share'
      page.should have_content public_portfolio_url(portfolio)
      sleep 20
      click_link 'Confirm'
      current_path.should == public_portfolio_path(portfolio)
    end

  end
end

describe 'Public Portfolio' do
  context 'asset breakdown page' do
    let(:portfolio) { create :portfolio }
    before :each do
      visit public_portfolio_path portfolio
    end
  end
end
