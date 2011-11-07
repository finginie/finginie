require 'spec_helper'

describe "Portfolios" do
  let (:portfolio) { create :portfolio, :user => user }
  login_user

  it "groups net positions by asset type" do
    stock_position = create :net_position, :security => create(:stock), :portfolio => portfolio
    loan_position = create :net_position, :security => create(:loan), :portfolio => portfolio
    fixed_income_position = create :net_position, :security => create(:fixed_income), :portfolio => portfolio
    visit portfolio_path portfolio
    within "section.Stock table" do
      page.should have_content stock_position.security.name
    end
    within "section.FixedIncome table" do
      page.should have_content fixed_income_position.security.name
    end
    within "section.Loan table" do
      page.should have_content loan_position.security.name
    end
  end
end
