require 'spec_helper'

describe FixedDepositDetail, :vcr do

  before(:each) do
    ENV['SPREADSHEET_KEY']      = "0AhUqTEsfdol7dEtnYVBYMndlM1ZhS0ptejVQSi1SVnc"
    ENV['SPREADSHEET_LOGIN']    = "sample@gmail.com"
    ENV['SPREADSHEET_PASSWORD'] = "sample"
    @collection = FixedDepositDetail.collection
  end

  it "should have collection of fixed deposit detail proxy" do
    @collection.first.class.should eq FixedDepositDetailProxy
  end

  it "should return result based on amount search" do
    @search = FixedDepositDetail.search({:amount => 10000})
    test_named_scope @collection, @search,
                     lambda{|u| u.min_amount <= 10000 && u.max_amount >= 10000 }
  end

  it "should return top five public banks" do
    bank = ["ANDHRA",
            "Indian Overseas Bank",
            "Bank of India",
            "Union Bank of India",
            "Canara Bank"
          ]
    FixedDepositDetail.top_public_banks.should include *bank
  end

  it "should return top five private banks" do
    bank =["Karur Vysya", "Kotak", "AXIS", "IDBI", "Yes"]
    FixedDepositDetail.top_private_banks.should include *bank
  end

  it "should have top five private banks interest rates" do
    bank = {
            "name"                      => "Karur Vysya",
            "sector"                    => "PRIVATE",
            "one_year_interest_rate"    => 10.0,
            "six_month_interest_rate"   => 7.8,
            "three_month_interest_rate" => 7.8,
            "one_month_interest_rate"   => 6.0
        }
    FixedDepositDetail.top_five_private_banks_interest_rates.first.should eq bank
  end

  it "should have top five public banks interest rates" do
    bank = {
            "name"                      => "ANDHRA",
            "sector"                    => "PUBLIC",
            "one_year_interest_rate"    => 9.4,
            "six_month_interest_rate"   => 8.5,
            "three_month_interest_rate" => 6.0,
            "one_month_interest_rate"   => 4.5
        }
    FixedDepositDetail.top_five_public_banks_interest_rates.first.should eq bank
  end

  it "should return result based on duration search" do
    @search = FixedDepositDetail.search({:duration => {:year => 1, :month => 1, :days => 1}})
    test_named_scope @collection, @search,
                     lambda{|u| u.min_duration <= 396 && u.max_duration >= 396 }
  end
end
