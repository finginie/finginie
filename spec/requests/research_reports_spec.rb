require 'spec_helper'

describe "ResearchReports",:vcr, :mongoid do

  it "should have link Research on homepage" do
    visit research_reports_path

    page.current_path.should eq research_reports_path
  end

  it "should have a link in Stock show page" do
    company = create :'data_provider/company', :name => 'Petronet LNG Ltd.', :nse_code => nil, :bse_code1 => '532522'
    visit stock_path(company)

    find(:link, "shares-#{company.to_param}-research_reports").click

    page.current_path.should eq stock_research_reports_path(:stock_id => 'petronet-lng-ltd')
  end

  it "should show latest reports in the index page" do
    visit research_reports_path
    page.should have_content "Emkay"
    tableish("table").should include (["Jun 27 2012", "Buy Petronet LNG; target of Rs 194", "Emkay", "Petronet LNG Ltd", "Oil and Gas"])
  end

  it "should search for reports in index page" do
    visit research_reports_path
    fill_in 'query', :with => "Angel"

    find_data_role('span', 'research_report_query').find('button').click

    tableish("table").should_not include (["Jun 27 2012", "Buy Petronet LNG; target of Rs 194", "Emkay", "Petronet LNG Ltd", "Oil and Gas"])
    tableish("table").should include (["May 28 2012", "Accumulate NMDC; target of Rs 187", "Angel Broking", "NMDC", "Mining"])
  end

  it "should show notice message when no search results" do
    visit research_reports_path
    fill_in 'query', :with => "Ged"

    find_data_role('span', 'research_report_query').find('button').click

    page.should have_content I18n.t('.empty_search')
  end

  it "should relevent message for search results" do
    visit research_reports_path
    fill_in 'query', :with => "Em"

    find_data_role('span', 'research_report_query').find('button').click

    page.should have_content I18n.t('.results_for_search', :term => 'Em')

  end

  it "should list all the reports for nse company" do
    create :'data_provider/company', :name => 'Petronet LNG Ltd.', :nse_code => 'PETRONET'
    visit stock_research_reports_path(:stock_id => 'petronet-lng-ltd')
    tableish("table").count.should eq 2
    tableish("table").should include (["Jun 27 2012", "Emkay", "Buy Petronet LNG; target of Rs 194", "140.00", "194.00", "Buy"])
  end

  it "should list all the reports for bse company" do
    create :'data_provider/company', :name => 'Petronet LNG Ltd.', :nse_code => nil, :bse_code1 => '532522'
    visit stock_research_reports_path(:stock_id => 'petronet-lng-ltd')
    tableish("table").count.should eq 2
    tableish("table").should include (["Jun 27 2012", "Emkay", "Buy Petronet LNG; target of Rs 194", "140.00", "194.00", "Buy"])
  end
end
