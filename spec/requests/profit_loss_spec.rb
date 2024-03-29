require 'spec_helper'

describe "Profit Loss" do
  let(:company) { create :'data_provider/company' }

  before (:each) do
    company.save
    5.times { |i| create :'data_provider/audited_result', :company_code          => company.code,
                                          :year_ending          => "31/03/#{2011 -i}",
                                          :operating_income     => "955255776000",
                                          :excise               => "9347100000",
                                          :reported_net_profit  => "82645190000",
                                          :number_of_equity_shares=> "634998991",
                                          :non_recurring_income => "912682000",
                                          :depreciation         => "9904952000",
                                          :material_consumed    => "118825100000",
                                          :cost_of_sales        => "793083335000"
    }
  end

  it "should show thw correct fields for non-banking sector" do
    visit stock_profit_loss_path(company)
    page.should have_content company.name
    page.should have_content "Sales"
    page.should have_content "96460"
    page.should have_content "Earning Per Share (Rs)"
    page.should have_content "130"
    page.should have_content "Total Material Consumed"
    page.should have_content "11883"
    page.should have_content "Cost of Sales"
    page.should have_content "79308"
  end

  it "should show the correct fields for banking-sector" do
    company.update_attribute(:major_sector, 2)
    visit stock_profit_loss_path(company)
    page.should have_content company.name
    page.should have_content "Income"
    page.should have_content "Operating Income"
    page.should have_content "95526"
    page.should have_content "Reported Net Profit"
    page.should have_content "8265"
    page.should have_content "Non Recurring Items"
    page.should have_content "91"
    page.should have_content "Depreciation"
    page.should have_content "990"
  end

  it "should have stock search in the stock profit loss page" do
    visit stock_path company
    click_link "Income Statement"
    page.should have_selector("#new_company")
  end

  it "should have a title" do
    visit stock_profit_loss_path( company)
    page.should have_selector("title", :content => I18n.t('profit_loss.title'))
  end
end
