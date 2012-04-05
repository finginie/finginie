require 'spec_helper'

describe "Stocks" do
  let (:company) { create :company }
  let (:scrip) { create :scrip, :id => company.nse_code, :last_traded_price => 24.22 }

  it "shows the stock details" do
    scrip.save
    visit stock_path(company.company_code)
    page.should have_content 24.22
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
