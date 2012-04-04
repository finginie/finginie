require 'spec_helper'

describe "Profit Loss" do
  let(:stock) { create :stock }
  let (:scrip) { create :scrip, :id => stock.symbol, :last_traded_price => 24.22 }
  let(:company) { create :company, :nse_code => stock.symbol }

  before (:each) do
    company.save
    5.times { |i| create :audited_result, :companycode          => company.company_code,
                                          :year_ending          => "31/03/#{2011 -i}",
                                          :operating_income     => "955255776000",
                                          :excise               => "9347100000",
                                          :reported_net_profit  => "82645190000",
                                          :numberof_equity_shares=> "634998991",
                                          :non_recurring_income => "912682000",
                                          :depreciation         => "9904952000",
                                          :material_consumed    => "118825100000",
                                          :cost_of_sales        => "793083335000"
    }
  end

  it "should show thw correct fields for non-banking sector" do
    visit stock_profit_loss_path(stock.id)
    page.should have_content stock.name
    page.should have_content "Sales"
    page.should have_content "96460.29"
    page.should have_content "Earning Per Share (Rs)"
    page.should have_content "130.15"
    page.should have_content "Total Material Consumed"
    page.should have_content "11882.51"
    page.should have_content "Cost of Sales"
    page.should have_content "79308.33"
  end

  it "should show the correct fields for banking-sector" do
    company.update_attribute(:major_sector, 2)
    visit stock_profit_loss_path(stock.id)
    page.should have_content stock.name
    page.should have_content "Income"
    page.should have_content "Operating Income"
    page.should have_content "95525.58"
    page.should have_content "Reported Net Profit"
    page.should have_content "8264.52"
    page.should have_content "Non Recurring Items"
    page.should have_content "91.27"
    page.should have_content "Depreciation"
    page.should have_content "990.5"
  end

  it "should have stock search in the stock profit loss page" do
    scrip.save
    visit stock_path stock
    click_link "Income Statement"
    page.should have_selector("#stock_search")
  end
end
