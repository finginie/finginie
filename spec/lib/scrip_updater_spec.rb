require 'spec_helper'
require 'scrip_updater'

# TODO: Mock out ftp requests
# As these tests stand now, they fetch data from tickerplant and provide reliable data only
# while the markets are still closed. Also the test data has to be changed day by day
describe ScripUpdater do
  it "gets and parses the scrip data" do
    pending "fails on weekends and early mornings"
    header =  ScripUpdater.fetch_data[0]
    header[:id].strip.should                 eq "Symbol"
    header[:time].strip.should               eq "LastTradedTime"
    header[:last_traded_price].strip.should  eq "LastTradedPrice"
    header[:volume].strip.should             eq "TotalTradedQty"
    header[:high_price].strip.should         eq "HighPrice"
    header[:low_price].strip.should          eq "LowPrice"
    header[:open_price].strip.should         eq "OpenPrice"
    header[:close_price].strip.should        eq "PreviousClose"
  end

  pending "updates the fetched records in the database"
end
