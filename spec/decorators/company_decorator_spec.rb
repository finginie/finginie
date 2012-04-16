require 'spec_helper'

describe CompanyDecorator, :redis do
  before { ApplicationController.new.set_current_view_context }
  let(:company) {create :company, :eps => '1424.32001', :ticker_name => "TIMSK" }
  let(:scrip) { create :scrip, :id => company.nse_code, :time => Time.now }
  let(:scrip_bse) { create :scrip_bse, :id => company.ticker_name, :bse_last_traded_price => 123.45 }
  let(:share_holding) { create :share_holding, :company_code => company.company_code }
  let(:company_decorator) { CompanyDecorator.decorate(company) }
  subject { company_decorator }

  its(:eps)      { should eq 1424.32 }
  its(:pe)       { should eq "N/A" }

  it "should have time for nse" do
    scrip.save
    subject.time.to_s.should eq scrip.time.to_s
  end

  it "should have time for bse" do
    scrip_bse.save
    subject.bse_time.should eq "N/A"
    subject.current_price.should eq 123.45
  end

  it "should have all share_holding percentages", :mongoid do
    share_holding.save
    subject.share_holding.foreign_institutional_investors_percentage.should eq 8.52
  end
end
