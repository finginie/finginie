require 'spec_helper'

describe "FixedDeposits", :vcr do
  describe "#Index" do

    before(:each) do
      ENV['SPREADSHEET_KEY']      = "0AhUqTEsfdol7dEtnYVBYMndlM1ZhS0ptejVQSi1SVnc"
      ENV['SPREADSHEET_LOGIN']    = "sample@gmail.com"
      ENV['SPREADSHEET_PASSWORD'] = "sample"
      FixedDepositDetail.collection
    end

    it "should list top five interest rates of private banks" do
      visit fixed_deposits_url

      private_sector_bank_table = [
                        ["Karur Vysya", "10.0", "7.8", "7.8", "6.0"]
                      ]
      tableish("#top_five_private_sector_interest_rate").should include *private_sector_bank_table
    end

    it "should list top five interest rates of public banks" do
      visit fixed_deposits_url

      public_sector_bank_table = [
                        ["ANDHRA", "9.4", "8.5", "6.0", "4.5"]
                      ]
      tableish("#top_five_public_sector_interest_rate").should include *public_sector_bank_table

    end

    it "user can search best fixed deposit interest rates" do
      visit fixed_deposits_url
      fill_in "Amount", :with => 1600000
      fill_in "Year", :with => 1
      fill_in "Month", :with => 1
      fill_in "Day", :with => 1
      choose "Yes"
      click_button "Submit"

      public_sector_bank_table = [
         ["Indian Overseas Bank", "9.25", "10.0"],
         ["ANDHRA"              , "9.4" , "9.9" ]
        ]

      private_sector_bank_table = [
         ["Karur Vysya", "10.0", "10.5"],
         ["AXIS", "9.25", "10.25"]
        ]

      tableish("#top_five_public_sector_interest_rate").should include *public_sector_bank_table
      tableish("#top_five_private_sector_interest_rate").should include *private_sector_bank_table
    end
  end
end
