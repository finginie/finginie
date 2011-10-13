require 'spec_helper'

describe StockQuote do
  describe "from quote" do
    it_should_behave_like "ActiveModel"

    let (:stock_quote) { StockQuote.new :id => "8118",
                                        :symbol => "AANJANEYA",
                                        :company_name => "Aanjaneya Lifecare",
                                        :best_buy_qty => "9008",
                                        :best_buy_price => "426.45",
                                        :best_sell_qty => "0",
                                        :best_sell_price => "0",
                                        :last_traded_price => "426.45",
                                        :volume => "87942",
                                        :net_change => "4.55",
                                        :percent_change => "1.08",
                                        :open_price => "425.40",
                                        :high_price => "432.5",
                                        :low_price => "419.15",
                                        :close_price => "421.90" }
    subject { stock_quote }

    it "should be persisted" do
      stock_quote.save.should be_true
    end

    describe "saved stock_quote" do
      before { stock_quote.save }
      it "should find a stock quote by id" do
        quote = StockQuote.find(8118)
        quote.should be_kind_of StockQuote
        quote.company_name.should eq "Aanjaneya Lifecare"
        quote.last_traded_price.should eq 426.45
      end

      it "should return nil for a missing stock quote" do
        StockQuote.find(999999999).should be_nil
      end
    end
  end
end
