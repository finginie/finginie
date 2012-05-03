require 'spec_helper'

describe CompanyDecorator, :redis, :mongoid do
  before { ApplicationController.new.set_current_view_context }
  let(:company) {create :company, :eps => '1424.32001', :ticker_name => "TIMSK", :market_capitalization => '2234567890' }
  let(:nse_scrip) { create :nse_scrip, :id => company.nse_code, :time => Time.now, :volume => 542632788 }
  let(:bse_scrip) { create :bse_scrip, :id => company.ticker_name, :last_traded_price => 123.45, :volume => 23456784523 }
  let(:share_holding) { create :share_holding, :company_code => company.company_code }
  let(:company_decorator) { CompanyDecorator.decorate(company) }
  subject { company_decorator }

  its(:eps)      { should eq 1424.32 }
  its(:pe)       { should eq "-" }
  its(:market_capitalization) { should eq 223 }

  describe "with Nse" do
    before(:each) { nse_scrip.save }
    it "should have time for nse" do
      subject.nse.time.to_s.should eq nse_scrip.time.to_s
    end

    it "should have volumes as comma seperated" do
      subject.nse.volume.should eq '54,26,32,788'
    end
  end

  describe "with bse" do
    before(:each) { bse_scrip.save }

    it "should have time for bse" do
      subject.bse.time.should eq "-"
      subject.current_price.should eq 123.45
    end

    it "should have volume comma seperated" do
      subject.bse.volume.should eq '23,45,67,84,523'
    end
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
