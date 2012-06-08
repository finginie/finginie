require 'spec_helper'

describe "ShareHolding", :mongoid do
  let(:company) { create :'data_provider/company' }
  before :each do
    @share_holding = create :'data_provider/share_holding', :company_code => company.code
  end

  it "should show the share holding profits_after_taxtern for a Stock" do
    visit stock_share_holding_path(company.name )
    page.should have_content 'Foreign Institional Investors (FIIs)'
    page.should have_content '8.52'
    page.should have_content 'Other Foreign Investors'
    page.should have_content '0.24'
    page.should have_content 'Others'
    page.should have_content '3.27'
    page.should have_content '0.43'
  end

  it "should have stock search in the stock share holding page" do
    visit stock_path company.name
    click_link "Ratios"
    page.should have_selector("#new_company")
  end

  it "should have a title" do
    visit stock_share_holding_path( company.name)
    page.should have_selector("title", :content => I18n.t('share_holding.title'))
  end
end
