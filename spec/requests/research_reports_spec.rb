require 'spec_helper'

describe "ResearchReports",:vcr, :mongoid do

  it "should have link Research on homepage" do
    visit root_path
    find('#navigation-research_reports a').click
    page.current_path.should eq research_reports_path
  end

  it "should have a link in Stock show page" do
    create :'data_provider/company', :name => 'Petronet LNG Ltd.', :nse_code => nil, :bse_code1 => '532522'
    visit stock_path(:id => 'petronet-lng-ltd')
    within ".level_3" do
      find('#navigation-research_reports a').click
    end
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
    click_on 'Search'
    tableish("table").should_not include (["Jun 27 2012", "Buy Petronet LNG; target of Rs 194", "Emkay", "Petronet LNG Ltd", "Oil and Gas"])
    tableish("table").should include (["May 28 2012", "Accumulate NMDC; target of Rs 187", "Angel Broking", "NMDC", "Mining"])
  end

  it "should show notice message when no search results" do
    visit research_reports_path
    fill_in 'query', :with => "Ged"
    click_on 'Search'
    page.should have_content I18n.t('.empty_search')
  end

  it "should relevent message for search results" do
    visit research_reports_path
    fill_in 'query', :with => "Em"
    click_on 'Search'
    page.should have_content I18n.t('.results_for_search', :term => 'Em')

  end

  it "should list all the reports for nse company" do
    create :'data_provider/company', :name => 'Petronet LNG Ltd.', :nse_code => 'PETRONET'
    visit stock_research_reports_path(:stock_id => 'petronet-lng-ltd')
    tableish("table").count.should eq 2
    tableish("table").should include (["Jun 27 2012", "Emkay", "Buy Petronet LNG; target of Rs 194", "140.00", "194", "Buy"])
  end

  it "should list all the reports for bse company" do
    create :'data_provider/company', :name => 'Petronet LNG Ltd.', :nse_code => nil, :bse_code1 => '532522'
    visit stock_research_reports_path(:stock_id => 'petronet-lng-ltd')
    tableish("table").count.should eq 2
    tableish("table").should include (["Jun 27 2012", "Emkay", "Buy Petronet LNG; target of Rs 194", "140.00", "194", "Buy"])
  end
end
