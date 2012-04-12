require 'spec_helper'

describe Company do
  let(:company) { create :company, :ticker_name => 'TICK' }
  let(:share_holding) { create :share_holding, :company_code => company.company_code }

  subject { company }
  it { should validate_presence_of :company_code }
  it { should validate_presence_of :company_name }
  it { should validate_uniqueness_of(:company_code).with_message(/is already taken/) }
  it { should validate_uniqueness_of(:company_name).with_message(/is already taken/) }

  it "should get the company record" do
    Company.find_or_initialize_by( company_code: company.company_code ).should eq company
  end

  it "should have a share holding" do
    share_holding.save
    subject.share_holding.should eq share_holding
  end

   describe "with scrip", :redis do
    before :each do
      create :scrip, :id => company.nse_code, :last_traded_price => 24, :close_price => 23
    end

    its(:last_traded_price) { should eq 24   }
    its(:current_price)     { should eq 24   }
    its(:net_change)        { should eq 1    }
    its(:percent_change)    { should eq 4.35 }
  end

  describe "with scrip_bse", :redis do
    before :each do
      create :scrip_bse, :id => company.ticker_name, :bse_last_traded_price => 15, :bse_close_price => 14.5
    end

    its(:bse_last_traded_price) { should eq 15   }
    its(:current_price)         { should eq 15   }
    its(:bse_close_price)       { should eq 14.5 }
    its(:bse_net_change)        { should eq 0.5  }
    its(:bse_percent_change)    { should eq 3.45 }
  end

  describe "with news" do
    before :each do
      6.times { |i| create :news, :company_code => company.company_code, :headlines => "headlines #{i}", :modify_on => Time.now - i }
    end
    it "should get all the news for a company" do
      company.news_headlines.should include( "headlines 0", "headlines 1", "headlines 2", "headlines 3", "headlines 4" )
      company.news_headlines.should_not include "headlines 5"
    end
  end

end
