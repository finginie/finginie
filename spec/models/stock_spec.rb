require 'spec_helper'

describe Stock do
  let (:stock) { create :stock }
  subject { stock }

  it { should validate_uniqueness_of :name }

  describe "with scrip", :redis do
    before :each do
      create :scrip, :id => stock.id, :last_traded_price => 24, :percent_change => 50
    end

    it "should filter by last traded price range" do
      another_stock = create :stock
      create :scrip, :id => another_stock.id, :last_traded_price => 30

      Stock.by_last_traded_price(20, 25).should include stock
      Stock.by_last_traded_price(20, 25).should_not include another_stock
    end

    it "should filter by percent change range" do
      another_stock = create :stock
      create :scrip, :id => another_stock.id, :percent_change => 30

      Stock.by_percent_change(40, 60).should include stock
      Stock.by_percent_change(40, 60).should_not include another_stock
    end
  end
end
