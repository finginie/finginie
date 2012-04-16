require 'spec_helper'

describe CompanyDecorator do
  before { ApplicationController.new.set_current_view_context }
  let(:company) {create :company, :eps => '1424.32001' }
  let(:share_holding) { create :share_holding, :company_code => company.company_code }
  let(:company_decorator) { CompanyDecorator.decorate(company) }
  subject { company_decorator }

  its(:eps) { should eq 1424.32 }

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
