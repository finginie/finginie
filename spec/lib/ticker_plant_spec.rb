require 'spec_helper'
require 'ticker_plant'

# TODO: Mock out ftp requests
# As these tests stand now, they fetch data from tickerplant and provide reliable data only
# while the markets are still closed. Also the test data has to be changed day by day
describe TickerPlant do
  pending "gets and parses the scrip data" do
    sample =  TickerPlant.fetch_data(:scrip)[0]
    sample[:id].should eq "4283"
    sample[:symbol].should eq "TNTELE"
    sample[:best_buy_qty].should eq "0"
    sample[:best_buy_price].should eq "0.00"
    sample[:best_sell_qty].should eq "0"
    sample[:best_sell_price].should eq "0.00"
    sample[:last_traded_price].should eq "4.30"
    sample[:volume].should eq "8631"
    sample[:net_change].should eq "-0.15"
    sample[:percent_change].should eq "-3.37"
    sample[:high_price].should eq "4.70"
    sample[:low_price].should eq "4.25"
  end

  pending "gets and parses end of the day data" do
    sample = TickerPlant.fetch_data(:stock)[0]
    sample[:id].should eq "1"
    sample[:name].should eq "3i Infotech Ltd"
    sample[:symbol].should eq "3IINFOTECH"
    sample[:sector].should eq "Computers - Software - Secondary"
    sample[:beta].should eq "0.86"
    sample[:eps].should eq "6.44"
    sample[:pe].should eq "4.22"
    sample[:fifty_two_week_high_price].should eq "72.15"
    sample[:fifty_two_week_high_date].should eq "11-Nov-10"
    sample[:fifty_two_week_low_price].should eq "25.25"
    sample[:fifty_two_week_low_date].should eq "26-Aug-11"
  end

  pending "updates the fetched records in the database"
end
