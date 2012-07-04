require 'spec_helper'

describe ResearchReport do
  it "should return a list of research reports" do
    ResearchReport.all.first.should be_a ResearchReport
  end

  it "should not have header row in records" do
    ResearchReport.all.first.source.should_not eq "Source"
  end

  it "should filter reports by keyword" do
    ResearchReport.filter({ :query => "Angel"}).count.should eq 2
  end

  it "should give all records when searched for nil" do
    ResearchReport.filter({}).count.should eq 10
  end

  it "should remove tailing white and leading white spaces from records" do
    ResearchReport.all.first.source.should eq 'Emkay'
  end

  it "should filter reports by nse code" do
    reports = ResearchReport.filter({:nse_code => 'NMDC'})
    reports.count.should eq 2
    reports.first.sector.should eq 'Mining'
  end

  it "should not get any reports when filtered by nil nse_code" do
    ResearchReport.filter({:nse_code => nil}).count.should eq 0
  end
end
