require 'spec_helper'

describe CompanyDecorator, :redis, :mongoid do
  before { ApplicationController.new.set_current_view_context }
  let(:company) {create :company, :eps => '1424.32001', :ticker_name => "TIMSK", :market_capitalization => '2234567890' }
  let(:nse_scrip) { create :nse_scrip, :id => company.nse_code, :time => Time.now }
  let(:bse_scrip) { create :bse_scrip, :id => company.ticker_name, :last_traded_price => 123.45 }
  let(:share_holding) { create :share_holding, :company_code => company.company_code }
  let(:company_decorator) { CompanyDecorator.decorate(company) }
  subject { company_decorator }

  its(:eps)      { should eq 1424.32 }
  its(:pe)       { should eq "N/A" }
  its(:market_capitalization) { should eq 223 }

  it "should have time for nse" do
    nse_scrip.save
    subject.nse.time.to_s.should eq nse_scrip.time.to_s
  end

  it "should have time for bse" do
    bse_scrip.save
    subject.bse.time.should eq "N/A"
    subject.current_price.should eq 123.45
  end

  it "should have all share_holding percentages", :mongoid do
    share_holding.save
    subject.share_holding.foreign_institutional_investors_percentage.should eq 8.52
  end

  describe "with news" do
    before :each do
      6.times { |i| create :news, :company_code => company.company_code, :headlines => "headlines #{i}", :modify_on => Time.now - i }
    end
    it "should get all the news for a company" do
      CompanyDecorator.decorate(company).news.map(&:headlines).should include( "headlines 0", "headlines 1", "headlines 2", "headlines 3", "headlines 4" )
    end
  end

end
