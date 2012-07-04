require 'spec_helper'

describe ResearchReport do
  it "should return a list of research reports" do
    ResearchReport.all.first.should be_a ResearchReport
  end

  it "should not have header row in records" do
    ResearchReport.all.first.source.should_not eq "Source"
  end

  it "should filter reports by keyword" do
    ResearchReport.filter("Angel").count.should eq 2
  end

  it "should give all records when searched for nil" do
    ResearchReport.filter(nil).count.should eq 10
  end
end
