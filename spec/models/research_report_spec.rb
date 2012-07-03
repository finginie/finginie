require 'spec_helper'

describe ResearchReport do
  it "should return a list of research reports" do
    ResearchReport.all.first.should be_a ResearchReport
    ResearchReport.count.should eq 1
  end
end
