require 'spec_helper'

describe "BalanceSheet" do
  let(:company) { create :company }

  before (:each) do
    5.times { |i| create :audited_result, :companycode            => company.company_code,
                                          :year_ending            => "31/03/#{2011 -i}",
                                          :investments            => "2956005690000",
                                          :long_term_loan         => "111111111",
                                          :unsecured_term_loans   => "121223344",
                                          :cash_credits           => "3398253341000",
                                          :bills_purchased        => "517157819000",
                                          :term_loans             => "3651783320000",
                                          :numberof_equity_shares => "634998991"
    }
  end

  it "should show the correct fields for non-banking sector" do
    visit stock_balance_sheet_path(company.company_code)
    page.should have_content company.company_name
    page.should have_content "Investments"
    page.should have_content "295601"
    page.should have_content "Total Debt"
    page.should have_content "23"
    page.should have_content "2011"

  end

  it "should show the correct fields for banking-sector" do
     company.update_attribute(:major_sector, 2)
     visit stock_balance_sheet_path( company.company_code)
     page.should have_content "Investments"
     page.should have_content "295601"
     page.should have_content "Advances"
     page.should have_content "756719"
     page.should have_content "6350"
  end

  it "should have stock search in the balance sheet page" do
    visit stock_path company.company_code
    click_link "Balance Sheet"
    page.should have_selector("#new_company")
  end

  it "should have a title" do
    visit stock_balance_sheet_path( company.company_code)
    page.should have_selector("title", :content => I18n.t('balance_sheet.title'))
  end
end
