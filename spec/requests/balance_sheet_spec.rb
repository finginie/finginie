require 'spec_helper'

describe "BalanceSheet" do
  let(:stock) { create :stock }
  let(:company_master) { create :company_master, :nse_code => stock.symbol }

  before (:each) do
    company_master.save
    5.times { |i| create :audited_result, :companycode            => company_master.company_code,
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
    visit stock_balance_sheet_path(stock.id)
    page.should have_content company_master.company_name
    page.should have_content "Investments"
    page.should have_content "295600.57"
    page.should have_content "Total Debt"
    page.should have_content "23.23"
    page.should have_content "2011"

  end

  it "should show the correct fields for banking-sector" do
     company_master.update_attribute(:major_sector, 2)
     visit stock_balance_sheet_path( stock.id)
     page.should have_content "Investments"
     page.should have_content "295600.57"
     page.should have_content "Advances"
     page.should have_content "756719.45"
     page.should have_content "6349.99"
  end
end