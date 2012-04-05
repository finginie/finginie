
require 'spec_helper'

describe "BalanceSheet" do
  let(:company) { create :company }
  let (:scrip) { create :scrip, :id => company.nse_code, :last_traded_price => 24.22 }

  it "should show the correct view for cash flow" do
    5.times { |i| create :cash_flow, :company_code => company.company_code,
                                     :year_ending => "31/03/#{2006 + i}",
                                     :pl_sale_asst =>	"104562000" }
    create :cash_flow, :company_code => company.company_code, :year_ending => "31/03/2011", :adv_tax_paid => "212342343"
    visit stock_cash_flow_path(company.company_code)
    page.should have_content company.company_name
    page.should have_content "Profit/Loss On Sale Of Assets"
    page.should have_content "10.46"
    page.should have_content "Advance Tax Paid"
    page.should have_content "21.23"
    page.should_not have_content "Loan And Advances"
  end

  it "should have stock search in the cash flow page" do
    scrip.save
    visit stock_path company.company_code
    click_link "Cash Flow"
    page.should have_selector("#new_company")
  end
end
