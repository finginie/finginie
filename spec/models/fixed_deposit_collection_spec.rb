require 'spec_helper'

describe FixedDepositCollection, :vcr do

  around(:each) do |spec|
    @collection = FixedDepositCollection.all
    Timecop.freeze(Date.civil(2012,03,22)) do
      spec.run
    end
  end

  it "should have collection of fixed deposit detail proxy" do
    @collection.first.class.should eq FixedDepositDetail
  end

  it "should return result based on amount search" do
    @search = FixedDepositCollection.search({:amount => 10000})
    test_named_scope FixedDepositCollection.search({}), @search,
                     lambda{|u| u.min_amount <= 10000 && u.max_amount >= 10000 }
  end

  it "should return top five public banks" do
    banks = ["Andhra Bank", "Indian Overseas Bank", "Bank of India", "Union Bank of India", "Canara Bank"]
    FixedDepositCollection.top_public_banks.should include *banks
  end

  it "should return top five private banks" do
    banks = ["Karur Vysya Bank", "Kotak Mahindra Bank", "Axis Bank", "Indus Ind Bank", "Yes Bank"]
    FixedDepositCollection.top_private_banks.should include *banks
  end

  it "should have top five private banks interest rates" do
    bank = Bank.new(
            name:                      "Karur Vysya Bank",
            sector:                    "PRIVATE",
            one_year_interest_rate:    10.0,
            six_month_interest_rate:   7.8,
            three_month_interest_rate: 7.8,
            one_month_interest_rate:   6.0
        )
    FixedDepositCollection.top_five_private_banks_interest_rates.first.should eq bank
  end

  it "should have top five public banks interest rates" do
    bank = Bank.new(
            name:                      "Andhra Bank",
            sector:                    "PUBLIC",
            one_year_interest_rate:    9.4,
            six_month_interest_rate:   8.5,
            three_month_interest_rate: 7.25,
            one_month_interest_rate:   4.5
        )
    FixedDepositCollection.top_five_public_banks_interest_rates.first.should eq bank
  end

  it "should return result based on duration search" do
    @search = FixedDepositCollection.search({:year => 1, :month => 1, :days => 1})
    test_named_scope FixedDepositCollection.search({}), @search,
                     lambda{|u| u.min_duration.to_i <= 396 && u.max_duration.to_i >= 396 }
  end

  it "should return result based on special tenure search" do
    @search = FixedDepositCollection.special_tenure({:year => 1, :month => 1, :days => 1})
    test_named_scope FixedDepositCollection.special_tenure({}), @search,
                     lambda{|u| u.min_duration <= 456 && u.min_duration >= 336 && u.max_duration.to_i == 0}
  end
end
