require 'spec_helper'

describe "Stocks" do
  let (:stock) { create :stock }
  let (:scrip) { create :scrip, :id => stock.symbol, :last_traded_price => 24.22 }

  it "shows the stock details" do
    scrip.save
    visit stock_path stock
    page.should have_content 24.22
  end

  it "should autocomplete stock name when user fill stock name", :js => true do
    scrip.save
    visit stocks_path

    page.execute_script %Q{ $('#search_name_contains').val("#{stock.name[0..5]}").keydown(); }
    wait_until {  page.should have_selector(".ui-menu-item a:contains('#{stock.name}')") }

    page.execute_script %Q{ $('.ui-menu-item a:contains("#{stock.name}")').trigger('mouseenter').click(); }
    page.current_path.should eq stock_path stock
  end

  it "should have search in the stock page", :js => true do
    scrip.save
    visit stock_path stock

    page.execute_script %Q{ $('#search_name_contains').val("#{stock.name[0..5]}").keydown(); }
    wait_until {  page.should have_selector(".ui-menu-item a:contains('#{stock.name}')") }

    page.execute_script %Q{ $('.ui-menu-item a:contains("#{stock.name}")').trigger('mouseenter').click(); }
    page.current_path.should eq stock_path stock
  end
end
