require 'net/ftp'
require 'zipruby'
require 'csv'

require File.expand_path('../../config/environment', __FILE__)

class TickerPlant
  DATA_SOURCES = {
    :scrip => {
      :url => "ftp.tickerplantindia.com",
      :username => "FORSKA",
      :password => "forska@123",
      :directory => "Feeder/NSE/NSE_EQ_QUOTES_15MIN"
    },
    :stock => {
      :url => "124.7.218.87",
      :username => "FORSKA",
      :password => "FORSKA@123"
    }
  }

  DATA_ATTRIBUTES = {
    :scrip => {
      :id => 0,
      :symbol => 1,
      :time => 4,
      :best_buy_qty => 5,
      :best_buy_price => 6,
      :best_sell_qty => 7,
      :best_sell_price => 8,
      :last_traded_price => 9,
      :volume => 10,
      :net_change => 11,
      :percent_change => 12,
      :high_price => 14,
      :low_price => 15
    },
    :stock => {
      :id => 0,
      :name => 1,
      :symbol => 3,
      :sector => 4,
      :beta => 5,
      :eps => 6,
      :pe => 7,
      :fifty_two_week_high_price => 8,
      :fifty_two_week_high_date => 9,
      :fifty_two_week_low_price => 10,
      :fifty_two_week_low_date => 11
    }
  }

  def self.update_records(type)
    self.fetch_data(type).each do |attributes|
      model = type.to_s.classify.constantize
      id = attributes.delete(:id)
      model.find_or_initialize_by_id(id).update_attributes(attributes)
    end
  end

  def self.fetch_data(type)
    data = []
    Net::FTP.open(DATA_SOURCES[type][:url], DATA_SOURCES[type][:username], DATA_SOURCES[type][:password]) do |ftp|
      ftp.chdir DATA_SOURCES[type][:directory] if DATA_SOURCES[type][:directory]
      return data unless file_name = ftp.nlst.last
      Zip::Archive.open_buffer (ftp.getbinaryfile file_name, nil) do |archive|
        csv_data = ''
        archive.fopen archive.get_name(0) do |f|
          while chunk = f.read
            csv_data << chunk
          end
        end
        CSV.parse csv_data, :col_sep => "|" do |row|
          row[0] = row[0].delete("<row>")
          row[-1] = row[-1].delete("</row>")
          data << attributes_hash(row, type)
        end
      end
    end

    data
  end

private

  def self.attributes_hash(row, type)
    Hash[ DATA_ATTRIBUTES[type].map { |key, value| [key, row[value]] } ]
  end
end
