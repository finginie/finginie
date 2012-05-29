require 'spec_helper'

describe "Stocks", :mongoid do
  let (:company) { create :company, :ticker_name => 'TICK', :face_value => 8.24, :major_sector => 2 }
  let (:nse_scrip) { create :nse_scrip, :id => company.nse_code, :last_traded_price => 24.22 }
  let (:bse_scrip) { create :bse_scrip, :id => company.ticker_name, :last_traded_price => 23.26, :close_price => 22 }

  it "shows the stock details" do
    nse_scrip.save
    bse_scrip.save

    visit stock_path(company.code)
    page.should have_content 24.22
    page.should have_content 23.26
    page.should have_content 8.24
  end

  it "should show 52 w high/low price on stock page" do
    create :listing, :exchange_code => 50, :scrip_code1_given_by_exchange => "#{company.nse_code}EQ", :fifty_two_week_high => 100.24, :low_date => "31/01/2012"
    create :listing, :exchange_code => 47, :scrip_code1_given_by_exchange => company.bse_code1, :fifty_two_week_low => 98.62, :high_date => "31/01/2012"

    visit stock_path(company.code)
    page.should have_content 100.24
    page.should have_content 98.62
  end

  it "should have ratios section for banking company" do
    @banking_ratio = create :banking_ratio, :company_code => company.code, :year_ending => '31/03/2011',
                                            :capital_adequacy_ratio => "13.64",
                                            :net_profit_margin      => "123.32",
                                            :yield_on_fund_advances => "462",
                                            :cost_of_funds_ratio    => "12.343"
    visit stock_path(company.code)
    page.should have_content 13.64
    page.should have_content 123.32
    page.should have_content 462
    page.should have_content 12.34

  end

  it "should have ratios section for non-banking company" do
    company.update_attribute( :major_sector, 1)
    @ratio = create :ratio, :company_code => company.code, :year_ending => '31/03/2011',
                                            :net_profit_margin => "241.23",
                                            :current_ratio     => "321.21"
    visit stock_path(company.code)
    page.should have_content 241.23
    page.should have_content 321.21

  end

  it "should have search in the stock page", :js => true do
    visit stock_path company.code

    page.execute_script %Q{ $('#company_name').val("#{company.name[0..5]}").keydown(); }

    wait_until {  page.should have_selector(".ui-menu-item a:contains('#{company.name}')") }

    page.execute_script %Q{ $('.ui-menu-item a:contains("#{company.name}")').trigger('mouseenter').click(); }
    page.current_path.should eq stock_path company.code
  end

  it "show page shouldn't throw any error when company not exists" do
    visit stock_path 25
    page.status_code.should eq 200
  end

  context "#index" do
    it "should have market indices" do
      create :bse_scrip, :id => "Sensex",    :last_traded_price => 10, :close_price => 9
      create :nse_scrip, :id => "NSE Index", :last_traded_price => 10, :close_price => 9
      create :nse_scrip, :id => "GOLDBEES",  :last_traded_price => 10, :close_price => 9

      visit stocks_path

      expected_table = [
                        ["10.0 1.0 ( 11.11 % )", "10.0 1.0 ( 11.11 % )", "100.0 10.0 ( 11.11 % )"]
                      ]

      tableish("table").should include *expected_table
    end

    it "should list top five gainers" do
      5.times do |i|
        top_gainer_company = create :company, :name => "GAINER#{i}", :ticker_name => 'Gain #{i}', :nse_code => "GAIN#{i}"
        create :nse_scrip, :id => top_gainer_company.nse_code, :last_traded_price => i+2, :close_price => i+1
      end

      visit stocks_path

      expected_content = [["GAINER0", "1.00", "100.00"], ["GAINER1", "1.00", "50.00"], ["GAINER2", "1.00", "33.33"], ["GAINER3", "1.00", "25.00"], ["GAINER4", "1.00", "20.00"]]
      tableish("#gainer").should include *expected_content
    end

    it "should list top five loser" do
      5.times do |i|
        top_loser_company = create :company, :name => "LOSER#{i}", :ticker_name => 'Lose #{i}', :nse_code => "LOSE#{i}"
        create :nse_scrip, :id => top_loser_company.nse_code, :last_traded_price => i+1, :close_price => i+2
      end

      visit stocks_path

      expected_content = [ ["LOSER0", "-1.00", "-50.00"], ["LOSER1", "-1.00", "-33.33"], ["LOSER2", "-1.00", "-25.00"], ["LOSER3", "-1.00", "-20.00"], ["LOSER4", "-1.00", "-16.67"] ]
      tableish("#loser").should include *expected_content
    end
  end

  context "#screener" do
    it "should have stock screener search", :js => true do
      company1 = create :company, pe: 1,  eps: 1,  price_to_book_value: 1,  book_value: 1,  :industry_name => "FOO"
      company2 = create :company, pe: 2,  eps: 2,  price_to_book_value: 2,  book_value: 2,  :industry_name => "BAR"

      visit screener_stocks_path

      fill_in "screener_pe_gt", :with => "1"
      fill_in "screener_pe_lt", :with => "2"

      fill_in "screener_eps_gt", :with => "1"
      fill_in "screener_eps_lt", :with => "2"

      fill_in "screener_book_value_gt", :with => "1"
      fill_in "screener_book_value_lt", :with => "2"

      fill_in "screener_price_to_book_value_gt", :with => "1"
      fill_in "screener_price_to_book_value_lt", :with => "2"

      click_button "Search"

      wait_until {  page.should have_selector("#stocks table") }

      expected_table = [
                           [ company1.name, "FOO", "", "", "1.0"],
                           [ company2.name, "BAR", "", "", "2.0"]
                        ]

      tableish("#stocks table").should include *expected_table
    end
  end

  context "Titles" do
    it "should have title for index page" do
      visit stocks_path
      page.should have_selector("title", :content => I18n.t('stocks.index.title'))
    end

    it "should have title for show page" do
      visit stock_path(company.code)
      page.should have_selector("title", :content => I18n.t('stocks.show.title'))
    end

  end
end
