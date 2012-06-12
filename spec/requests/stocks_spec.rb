require 'spec_helper'

describe "Stocks", :mongoid, :redis do
  let (:company) { create :'data_provider/company', :name => 'ABC InfoTech Ltd.', :ticker_name => 'TICK', :face_value => 8.24, :major_sector => 2 }
  let (:nse_scrip) { create :'data_provider/nse_scrip', :id => company.nse_code, :last_traded_price => 24.22, :close_price => 23.42 }
  let (:bse_scrip) { create :'data_provider/bse_scrip', :id => company.ticker_name, :last_traded_price => 23.26, :close_price => 22 }

  it "shows the stock details" do
    nse_scrip.save
    bse_scrip.save

    visit stock_path(company.name)
    page.should have_content 24.22
    page.should have_content 23.26
    page.should have_content 8.24
  end

  it "should show 52 w high/low price on stock page" do
    create :'data_provider/listing', :exchange_code => 50, :scrip_code1_given_by_exchange => "#{company.nse_code}EQ", :fifty_two_week_high => 100.24, :low_date => "31/01/2012"
    create :'data_provider/listing', :exchange_code => 47, :scrip_code1_given_by_exchange => company.bse_code1, :fifty_two_week_low => 98.62, :high_date => "31/01/2012"

    visit stock_path(company.name)
    page.should have_content 100.24
    page.should have_content 98.62
  end

  it "should have ratios section for banking company" do
    @banking_ratio = create :'data_provider/banking_ratio', :company_code => company.code, :year_ending => '31/03/2011',
                                            :capital_adequacy_ratio => "13.64",
                                            :net_profit_margin      => "123.32",
                                            :yield_on_fund_advances => "462",
                                            :cost_of_funds_ratio    => "12.343"
    visit stock_path(company.name)
    page.should have_content 13.64
    page.should have_content 123.32
    page.should have_content 462
    page.should have_content 12.34

  end

  it "should have ratios section for non-banking company" do
    company.update_attribute( :major_sector, 1)
    @ratio = create :'data_provider/ratio', :company_code => company.code, :year_ending => '31/03/2011',
                                            :net_profit_margin => "241.23",
                                            :current_ratio     => "321.21"
    visit stock_path(company.name)
    page.should have_content 241.23
    page.should have_content 321.21

  end

  it "should have search in the stock page", :js => true do
    visit stock_path company.name

    page.execute_script %Q{ $('[data-autocomplete-source]').val("#{company.name[0..5]}").keydown(); }

    wait_until {  page.should have_selector(".ui-menu-item a:contains('#{company.name}')") }

    page.execute_script %Q{ $('.ui-menu-item a:contains("#{company.name}")').trigger('mouseenter').click(); }

    page.current_path.should eq stock_path company.name
  end

  it "show page shouldn't throw any error when company not exists" do
    visit stock_path 25
    page.status_code.should eq 200
  end

  context "#index" do
    before(:each) do
      create :'data_provider/bse_scrip', :id => "Sensex",    :last_traded_price => 10, :close_price => 9
      create :'data_provider/nse_scrip', :id => "NSE Index", :last_traded_price => 10, :close_price => 9
      create :'data_provider/nse_scrip', :id => "GOLDBEES",  :last_traded_price => 10, :close_price => 9
    end

    it "should have search in index page", :js => true do
      5.times { |i| create :'data_provider/company', :name => "Company Tech#{i}" }

      visit stocks_path

      page.execute_script %Q{ $('#stocks_table_filter input').focus().val("Company").keyup(); }

      wait_until {  page.should have_selector("#stocks_table a:contains('Company Tech1')") }

      click_on 'Company Tech1'

      page.current_path.should eq stock_path 'Company Tech1'

    end

    it "should have market indices" do

      visit stocks_path

      expected_text = [
                        "Nifty 10.0 1.0 ( 11.11 % )", "Sensex 10.0 1.0 ( 11.11 % )", "Gold (10 gms) 100.0 10.0 ( 11.11 % )"
                      ]

      selector("#stock_indicies", "div").should include *expected_text
    end

    context "#Top Gainers" do
      before(:each) do
        5.times do |i|
          top_gainer_company = create :'data_provider/company', :name => "GAINER#{i}", :ticker_name => "Gain #{i}", :nse_code => "GAIN#{i}"
          create :'data_provider/nse_scrip', :id => top_gainer_company.nse_code, :last_traded_price => i+2, :close_price => i+1
          create :'data_provider/bse_scrip', :id => top_gainer_company.ticker_name, :last_traded_price => i+3, :close_price => i+2
        end
      end

      it "should list NSE top five gainers" do

        visit stocks_path

        expected_content = [["GAINER0", "2.00", "100.00"], ["GAINER1", "3.00", "50.00"], ["GAINER2", "4.00", "33.33"], ["GAINER3", "5.00", "25.00"], ["GAINER4", "6.00", "20.00"]]
        tableish("#nse_scrip_top_gainers").should include *expected_content
      end

      it "should list BSE top five gainers" do
        visit stocks_path

        expected_content = [["GAINER0", "3.00", "50.00"], ["GAINER1", "4.00", "33.33"], ["GAINER2", "5.00", "25.00"], ["GAINER3", "6.00", "20.00"], ["GAINER4", "7.00", "16.67"]]
        tableish("#bse_scrip_top_gainers").should include *expected_content

      end

      it "should go to corresponding stock page when a link in top gainers section is clicked on" do
        visit stocks_path

        within '#nse_scrip_top_gainers' do
          page.should have_selector("a", :content => 'GAINER1')
          click_on 'GAINER1'
          page.current_path.should eq stock_path 'GAINER1'
        end
      end
    end

    context "#top losers" do

      before(:each) do
        5.times do |i|
          top_loser_company = create :'data_provider/company', :name => "LOSER#{i}", :ticker_name => "Lose #{i}", :nse_code => "LOSE#{i}"
          create :'data_provider/nse_scrip', :id => top_loser_company.nse_code, :last_traded_price => i+1, :close_price => i+2
          create :'data_provider/bse_scrip', :id => top_loser_company.ticker_name, :last_traded_price => i+2, :close_price => i+3
        end
      end

      it "should list NSE top five losers" do

        visit stocks_path

        expected_content = [ ["LOSER0", "1.00", "-50.00"], ["LOSER1", "2.00", "-33.33"], ["LOSER2", "3.00", "-25.00"], ["LOSER3", "4.00", "-20.00"], ["LOSER4", "5.00", "-16.67"] ]
        tableish("#nse_scrip_top_losers").should include *expected_content
      end

      it "should list BSE top five losers" do

        visit stocks_path

        expected_content = [ ["LOSER0", "2.00", "-33.33"], ["LOSER1", "3.00", "-25.00"], ["LOSER2", "4.00", "-20.00"], ["LOSER3", "5.00", "-16.67"], ["LOSER4", "6.00", "-14.29"] ]
        tableish("#bse_scrip_top_losers").should include *expected_content

      end
    end   # end of context top losers

    context "#most active shares " do
      before(:each) do
        5.times do |i|
          active_company = create :'data_provider/company', :name => "ACTIVE#{i}", :ticker_name => "Active #{i}", :nse_code => "ACT#{i}"
          create :'data_provider/nse_scrip', :id => active_company.nse_code, :last_traded_price => i+1, :close_price => i+2, :volume => (20000 + i * 1000)
          create :'data_provider/bse_scrip', :id => active_company.ticker_name, :last_traded_price => i+2, :close_price => i+2, :volume => 10000 + i * 1000
        end
      end

      it "should have NSE most active shares" do
        visit stocks_path

        expected_content = [ ["ACTIVE0", "1.00", "20,000"], ["ACTIVE1", "2.00", "21,000"], ["ACTIVE2", "3.00", "22,000"], ["ACTIVE3", "4.00", "23,000"], ["ACTIVE4", "5.00", "24,000"] ]
        tableish("#nse_scrip_most_active").should include *expected_content
      end

      it "should have BSE most active shares" do
        visit stocks_path

        expected_content = [ ["ACTIVE0", "2.00", "10,000"], ["ACTIVE1", "3.00", "11,000"], ["ACTIVE2", "4.00", "12,000"], ["ACTIVE3", "5.00", "13,000"], ["ACTIVE4", "6.00", "14,000"] ]
        tableish("#bse_scrip_most_active").should include *expected_content

      end
    end  #  end of context most active

    it "should have sectoral indices" do
      create :'data_provider/nse_scrip', :id => 'CNXFIN', :last_traded_price => 11, :close_price => 10
      create :'data_provider/nse_scrip', :id => 'CNXAUTO', :last_traded_price => 9.5, :close_price => 10

      create :'data_provider/bse_scrip', :id => 'BSE Oil&Gas', :last_traded_price => 11, :close_price => 10
      create :'data_provider/bse_scrip', :id => 'BSE Smallcap', :last_traded_price => 9.5, :close_price => 10

      visit stocks_path

      expected_content_nse = [ [ I18n.t('stocks.sectoral_indices.CNXFIN'), '11.00', '1.00', '10.00' ],
                           [ I18n.t('stocks.sectoral_indices.CNXAUTO'), '9.50', '-0.50', '-5.00' ] ]

      expected_content_bse = [ [ I18n.t('stocks.sectoral_indices.BSEOilGas'), '11.00', '1.00', '10.00' ],
                           [ I18n.t('stocks.sectoral_indices.BSESmallcap'), '9.50', '-0.50', '-5.00' ] ]

      tableish("#nse_scrip_sectoral_indices").should include *expected_content_nse

      tableish("#bse_scrip_sectoral_indices").should include *expected_content_bse
    end
  end    #  end of context index

  context "#screener" do
    before(:each) do
      @company1 = create :'data_provider/company', pe: 1,  eps: 1,  price_to_book_value: 1,  book_value: 1,  :industry_name => "FOO"
      @company2 = create :'data_provider/company', pe: 2,  eps: 2,  price_to_book_value: 2,  book_value: 2,  :industry_name => "BAR"

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
    end

    it "should have stock screener search", :js => true do
      expected_table = [
                           [ @company1.name, "FOO", "", "", "1.0"],
                           [ @company2.name, "BAR", "", "", "2.0"]
                        ]

      tableish("#stocks table").should include *expected_table
    end

    it "should have link that follow to stock page", :js => true do
      page.should have_link(@company1.name, :href => stock_path(@company1.name))
    end
  end

  context "Titles" do
    it "should have title for index page" do
      visit stocks_path
      page.should have_selector("title", :content => I18n.t('stocks.index.title'))
    end

    it "should have title for show page" do
      visit stock_path(company.name)
      page.should have_selector("title", :content => I18n.t('stocks.show.title'))
    end

  end
end
