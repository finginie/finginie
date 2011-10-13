require 'clockwork'
require 'net/ftp'
require 'zipruby'
require 'csv'

require File.expand_path('../../config/environment', __FILE__) 

include Clockwork

handler do
  get_stock_data
end

every 1.minute, "Getting stock data"

def get_stock_data
  Net::FTP.open("ftp.tickerplantindia.com", "FORSKA", "forska@123") do |ftp|
    ftp.chdir "Feeder/NSE/NSE_EQ_QUOTES_15MIN"
    file_name = File.basename(ftp.nlst.last, ".zip")
    Zip::Archive.open_buffer (ftp.getbinaryfile "#{file_name}.zip", nil) do |archive|
      csv_data = ''
      archive.fopen archive.get_name(0) do |f|
        while chunk = f.read
          csv_data << chunk
        end
      end
      CSV.parse csv_data, :col_sep => "|" do |row|
        row[0] = row[0].delete("<row>")
        row[-1] = row[-1].delete("</row>")
        create_or_update row
      end
    end
  end
end

ATTRIBUTES = {
  :symbol => 1,
  :company_name => 3,
  :time => 4,
  :best_buy_qty => 5,
  :best_buy_price => 6,
  :best_sell_qty => 7,
  :best_sell_price => 8,
  :last_traded_price => 9,
  :volume => 10,
  :net_change => 11,
  :percent_change => 12,
  :open_price => 13,
  :high_price => 14,
  :low_price => 15,
  :close_price => 16
}

def create_or_update( row )
  tpil = row[0].to_i
  stock_quote = StockQuote.find(tpil) || StockQuote.new
  attributes_hash = Hash[ ATTRIBUTES.map { |key, value| [key, row[value]] } ]
  stock_quote.attributes(attributes_hash).save
end
