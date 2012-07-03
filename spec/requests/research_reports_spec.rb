require 'spec_helper'

describe "ResearchReports", :mongoid do

  it "should show latest reports in the index page" do
    visit research_reports_path
    page.should have_content "Emkay"
    tableish("table").should include (["Jun 27 2012", "Buy Petronet LNG; target of Rs 194", "Emkay", "Petronet LNG Ltd", "Oil and Gas"])
  end

  it "should search for reports in index page" do
    visit research_reports_path
    fill_in 'report_nsecode', :with => "Angel"
    click_on 'Search'
    tableish("table").should include (["May 28 2012", "Accumulate NMDC; target of Rs 187", "Angel Broking", "NMDC", "Mining"])
  end

  pending "should list all the reports for nse company" do
    create :'data_provider/company', :name => 'Petronet LNG Ltd.', :nse_code => 'PETRONET'
    visit stock_research_reports_path(:stock_id => 'petronet-lng-ltd')
    tableish("table").should include (["Jun 27 2012", "Emkay", "Buy Petronet LNG; target of Rs 194", "140.00", "194", "Buy"])
  end

  pending "should list all the reports for bse company" do
    create :'data_provider/company', :name => 'Petronet LNG Ltd.', :nse_code => nil, :bse_code1 => '532522'
    visit stock_research_reports_path(:stock_id => 'petronet-lng-ltd')
    tableish("table").should include (["Jun 27 2012", "Emkay", "Buy Petronet LNG; target of Rs 194", "140.00", "194", "Buy"])
  end
end
