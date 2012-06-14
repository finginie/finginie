require 'spec_helper'

describe "FixedDeposits", :vcr do
  describe "#Index" do

    before(:each) do
      FixedDepositCollection.all
    end

    it "should list top five interest rates of private banks" do
      Timecop.freeze(Date.civil(2012,03,22)) do
        visit fixed_deposits_url

        private_sector_bank_table = [
                          ["Karur Vysya Bank", "10.0", "7.8", "7.8", "6.0"]
                        ]
        tableish("#top_five_private_sector_interest_rate").should include *private_sector_bank_table
      end
    end

    it "should list top five interest rates of public banks" do
      Timecop.freeze(Date.civil(2012,03,22)) do
        visit fixed_deposits_url

        public_sector_bank_table = [
                          ["Andhra Bank", "9.4", "8.5", "7.25", "4.5"]
                        ]
        tableish("#top_five_public_sector_interest_rate").should include *public_sector_bank_table
      end
    end

    context "user can search best fixed deposit interest rates" do
      before(:each) do
        Timecop.freeze(Date.civil(2012,03,22)) do
          visit fixed_deposits_url

          fill_in "fixed_deposit_detail_amount", :with => 1600000
          fill_in "fixed_deposit_detail_year",   :with => 1
          fill_in "fixed_deposit_detail_month",  :with => 1
          fill_in "fixed_deposit_detail_days",   :with => 1

          choose "Yes"

          click_button "Submit"

        end
      end

      it "should list all top public and private bank sector interest rate" do
        public_sector_bank_table = [
           ["Indian Overseas Bank", "10.0"],
           ["Andhra Bank"         , "9.9" ]
          ]

        private_sector_bank_table = [
           ["Karur Vysya Bank", "10.5" ],
           ["Axis Bank",        "10.25"]
          ]

        tableish("#top_five_public_sector_interest_rate").should include *public_sector_bank_table
        tableish("#top_five_private_sector_interest_rate").should include *private_sector_bank_table
      end

      it "should list special days interest rate closed to duration search" do
        special_tenure = [
            ["Bank of Baroda", "444", "9.35"]
          ]
        tableish("#special_tenure").should include *special_tenure
      end
    end
  end
end
