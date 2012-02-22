require 'spec_helper'

describe Stock do
  let (:stock) { create :stock }
  let (:company_master) { create :company_master, :nse_code => stock.symbol }
  subject { stock }

  it { should validate_uniqueness_of :name }
  it { should validate_uniqueness_of :symbol }
  its(:company_code) { should eq company_master.company_code }

  it "should mass assign attributes" do
    Stock.find_or_initialize_by_id(1).update_attributes({
      :name                      => "3i Infotech Ltd",
      :symbol                    => "3IINFOTECH",
      :sector                    => "Computers - Software - Secondary",
      :beta                      => "0.86",
      :eps                       => "6.44",
      :pe                        => "4.22",
      :fifty_two_week_high_price => "72.15",
      :fifty_two_week_high_date  => "11-Nov-10",
      :fifty_two_week_low_price  => "25.25",
      :fifty_two_week_low_date   => "26-Aug-11"
    })
  end

  describe "with scrip", :redis do
    before :each do
      create :scrip, :id => stock.symbol, :last_traded_price => 24, :percent_change => 50
    end

    its(:last_traded_price) { should eq 24 }
    its(:percent_change) { should eq 50 }

    it "should filter by last traded price range" do
      another_stock = create :stock
      create :scrip, :id => another_stock.symbol, :last_traded_price => 30

      Stock.by_last_traded_price(20, 25).should include stock
      Stock.by_last_traded_price(20, 25).should_not include another_stock
    end

    it "should filter by percent change range" do
      another_stock = create :stock
      create :scrip, :id => another_stock.symbol, :percent_change => 30

      Stock.by_percent_change(40, 60).should include stock
      Stock.by_percent_change(40, 60).should_not include another_stock
    end
  end

  describe "with news", :mongoid do
    before :each do
      @company = create :company_master, :company_code => "123234", :nse_code => stock.symbol
      6.times { |i| create :news, :company_code => @company.company_code, :headlines => "headlines #{i}", :modify_on => Time.now - i }
    end
    it "should get all the news for a company" do
      stock.news_headlines.should include( "headlines 0", "headlines 1", "headlines 2", "headlines 3", "headlines 4" )
      stock.news_headlines.should_not include "headlines 5"
    end
  end
end
