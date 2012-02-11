
require 'spec_helper'

describe "BalanceSheet" do
  let(:stock) { create :stock }
  let(:company_master) { create :company_master, :nse_code => stock.symbol }

  it "should show the correct view for cash flow" do
    5.times { |i| create :cash_flow, :company_code => company_master.company_code,
                                     :year_ending => "31/03/#{2006 + i}",
                                     :pl_sale_asst =>	"104562000"
    }
    create :cash_flow, :company_code => company_master.company_code, :year_ending => "31/03/2011", :adv_tax_paid => "212342343"
    visit stock_cash_flow_path(stock.id)
    page.should have_content stock.name
    page.should have_content "Profit/Loss On Sale Of Assets"
    page.should have_content "10.46"
    page.should have_content "Advance Tax Paid"
    page.should have_content "21.23"
    page.should_not have_content "Loan And Advances"
  end
end
