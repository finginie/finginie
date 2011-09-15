require 'spec_helper'

describe StockQuote do
  describe "from quote" do
    it_should_behave_like "ActiveModel"

    let (:stock_quote) { StockQuote.from_quote "8118", "AANJANEYA", "EQ", "Aanjaneya Lifecare", "15-September-2011 15:56:11", "9008", "426.45", "0", "0.00", "426.45", "87942", "4.55", "1.08", "425.40", "432.50", "419.15", "421.90" }
    subject { stock_quote }

    its(:id)                { should eq 8118 }
    its(:symbol)            { should eq "AANJANEYA" }
    its(:company_name)      { should eq "Aanjaneya Lifecare" }
    its(:time)              { should eq "15-September-2011 15:56:11" }
    its(:time)              { should be_kind_of DateTime }
    its(:best_buy_qty)      { should eq 9008 }
    its(:best_buy_price)    { should eq 426.45 }
    its(:best_sell_qty)     { should eq 0 }
    its(:best_sell_price)   { should eq 0 }
    its(:last_traded_price) { should eq 426.45 }
    its(:volume)            { should eq 87942 }
    its(:net_change)        { should eq 4.55 }
    its(:percent_change)    { should eq 1.08 }
    its(:open_price)        { should eq 425.40 }
    its(:high_price)        { should eq 432.5 }
    its(:low_price)         { should eq 419.15 }
    its(:close_price)       { should eq 421.90 }

    it "should be persisted" do
      stock_quote.save.should be_true
    end

    describe "saved stock_quote" do
      before { stock_quote.save }
      pending "should retrieve the stock by name" do
        quote = StockQuote.find_by_name("Aanjaneya Lifecare")
        quote.should be_kind_of StockQuote
        quote.id.should eq 8118
        quote.symbol.should eq "AANJANEYA"
      end
    end
  end
end
