
require 'spec_helper'

describe "CashFlow", :mongoid do
  let(:company) { create :'data_provider/company' }

  it "should show the correct view for cash flow" do
    5.times { |i| create :'data_provider/cash_flow', :company_code => company.code,
                                     :year_ending => "31/03/#{2006 + i}",
                                     :pl_on_sale_of_assets => "104562000" }
    create :'data_provider/cash_flow', :company_code => company.code, :year_ending => "31/03/2011", :advance_tax_paid => "212342343"
    visit stock_cash_flow_path(company)
    page.should have_content company.name
    page.should have_content "Profit/Loss On Sale Of Assets"
    page.should have_content "10"
    page.should have_content "Advance Tax Paid"
    page.should have_content "21"
    page.should_not have_content "Loan And Advances"
  end

  it "should have stock search in the cash flow page" do
    visit stock_path company
    click_link "Cash Flow"
    page.should have_selector("#new_company")
  end

  it "should have a title" do
    visit stock_cash_flow_path(company)
    page.should have_selector("title", :content => I18n.t('cash_flow.title'))
  end
end
