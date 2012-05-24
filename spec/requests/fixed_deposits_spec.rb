require 'spec_helper'

describe "FixedDeposits", :vcr do
  describe "#Index" do

    before(:each) do
      FixedDepositDetail.collection
    end

    it "should list top five interest rates of private banks" do
      visit fixed_deposits_url

      private_sector_bank_table = [
                        ["Karur Vysya Bank", "10.0", "7.8", "7.8", "6.0"]
                      ]
      tableish("#top_five_private_sector_interest_rate").should include *private_sector_bank_table
    end

    it "should list top five interest rates of public banks" do
      visit fixed_deposits_url

      public_sector_bank_table = [
                        ["Andhra Bank", "9.4", "8.5", "6.0", "4.5"]
                      ]
      tableish("#top_five_public_sector_interest_rate").should include *public_sector_bank_table

    end

    it "user can search best fixed deposit interest rates" do
      visit fixed_deposits_url

      fill_in "fixed_deposit_detail_proxy_amount", :with => 1600000
      fill_in "fixed_deposit_detail_proxy_duration_year", :with => 1
      fill_in "fixed_deposit_detail_proxy_duration_month", :with => 1
      fill_in "fixed_deposit_detail_proxy_duration_days", :with => 1

      choose "Yes"

      click_button "Submit"

      public_sector_bank_table = [
         ["Indian Overseas Bank", "9.25", "10.0"],
         ["Andhra Bank"         , "9.4" , "9.9" ]
        ]

      private_sector_bank_table = [
         ["Karur Vysya Bank", "10.0", "10.5" ],
         ["Axis Bank",        "9.25", "10.25"]
        ]

      tableish("#top_five_public_sector_interest_rate").should include *public_sector_bank_table
      tableish("#top_five_private_sector_interest_rate").should include *private_sector_bank_table
    end
  end
end
