require 'spec_helper'

describe "Stocks" do
  let (:company) { create :company, :ticker_name => 'TICK', :face_value => 8.24, :major_sector => 2 }
  let (:nse_scrip) { create :nse_scrip, :id => company.nse_code, :last_traded_price => 24.22 }
  let (:bse_scrip) { create :bse_scrip, :id => company.ticker_name, :last_traded_price => 23.26, :close_price => 22 }

  it "shows the stock details" do
    nse_scrip.save
    bse_scrip.save

    visit stock_path(company.company_code)
    page.should have_content 24.22
    page.should have_content 23.26
    page.should have_content 8.24
  end

  it "should show 52 w high/low price on stock page" do
    create :listing, :exchange_code => 50, :scrip_code1_given_by_exchange => "#{company.nse_code}EQ", :fifty_two_week_high => 100.24, :low_date => "31/01/2012"
    create :listing, :exchange_code => 47, :scrip_code1_given_by_exchange => company.bse_code1, :fifty_two_week_low => 98.62, :high_date => "31/01/2012"

    visit stock_path(company.company_code)
    page.should have_content 100.24
    page.should have_content 98.62
  end

  it "should have ratios section for banking company" do
    @banking_ratio = create :banking_ratio, :company_code => company.company_code, :year_ending => '31/03/2011',
                                            :capital_adequacy_ratio => "13.64",
                                            :net_profit_margin      => "123.32",
                                            :yield_on_fund_advances => "462",
                                            :cost_of_funds_ratio    => "12.343"
    visit stock_path(company.company_code)
    page.should have_content 13.64
    page.should have_content 123.32
    page.should have_content 462
    page.should have_content 12.34

  end

  it "should have ratios section for non-banking company" do
    company.update_attribute( :major_sector, 1)
    @ratio = create :ratio, :company_code => company.company_code, :year_ending => '31/03/2011',
                                            :net_profit_margin => "241.23",
                                            :current_ratio     => "321.21"
    visit stock_path(company.company_code)
    page.should have_content 241.23
    page.should have_content 321.21

  end

  it "should have search in the stock page", :js => true do
    visit stock_path company.company_code

    page.execute_script %Q{ $('#company_company_name').val("#{company.company_name[0..5]}").keydown(); }
    wait_until {  page.should have_selector(".ui-menu-item a:contains('#{company.company_name}')") }

    page.execute_script %Q{ $('.ui-menu-item a:contains("#{company.company_name}")').trigger('mouseenter').click(); }
    page.current_path.should eq stock_path company.company_code.to_i
  end

  it "show page shouldn't throw any error when company not exists" do
    visit stock_path 25
    page.status_code.should eq 200
  end

  context "index page" do
    it "should have indices" do
      create :bse_scrip, :id => "Sensex",    :last_traded_price => 10, :close_price => 9
      create :nse_scrip, :id => "NSE Index", :last_traded_price => 10, :close_price => 9
      create :nse_scrip, :id => "GOLDBEES",  :last_traded_price => 10, :close_price => 9

      visit stocks_path

      expected_table = [
                        ["10.0 1.0 ( 11.11 % )", "10.0 1.0 ( 11.11 % )", "10.0 1.0 ( 11.11 % )"]
                      ]

      tableish("table").should include *expected_table
    end
  end
end
