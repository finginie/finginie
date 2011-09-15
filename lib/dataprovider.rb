require 'clockwork'
require 'net/ftp'
require 'zipruby'
require 'csv'

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

def create_or_update( row )
#                     tp_code,
#                     symbol,
#                     series,
#                     company_name,
#                     time,
#                     best_buy_qty,
#                     best_buy_price,
#                     best_sell_qty,
#                     best_sell_price,
#                     last_traded_price,
#                     volume,
#                     net_change,
#                     percent_change,
#                     open_price,
#                     high_price,
#                     low_price,
#                     close_price
  tpil = row.delete_at(0)
  print [tpil.to_sym , row ]
end
