require 'spec_helper'

describe "Stocks" do
  let (:company) { create :company, :ticker_name => 'TICK', :face_value => 8.24 }
  let (:scrip) { create :scrip, :id => company.nse_code, :last_traded_price => 24.22 }
  let (:scrip_bse) { create :scrip_bse, :id => company.ticker_name, :bse_last_traded_price => 23.26, :bse_close_price => 22 }

  it "shows the stock details" do
    scrip.save
    scrip_bse.save

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

  it "should autocomplete stock name when user fill stock name", :js => true do
    scrip.save
    visit stocks_path

    page.execute_script %Q{ $('#company_company_name').val("#{company.company_name[0..5]}").keydown(); }
    wait_until {  page.should have_selector(".ui-menu-item a:contains('#{company.company_name}')") }

    page.execute_script %Q{ $('.ui-menu-item a:contains("#{company.company_name}")').trigger('mouseenter').click(); }
    page.current_path.should eq stock_path company.company_code.to_i
  end

  it "should have search in the stock page", :js => true do
    scrip.save
    visit stock_path company.company_code

    page.execute_script %Q{ $('#company_company_name').val("#{company.company_name[0..5]}").keydown(); }
    wait_until {  page.should have_selector(".ui-menu-item a:contains('#{company.company_name}')") }

    page.execute_script %Q{ $('.ui-menu-item a:contains("#{company.company_name}")').trigger('mouseenter').click(); }
    page.current_path.should eq stock_path company.company_code.to_i
  end
end
