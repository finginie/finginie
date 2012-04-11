require 'net/ftp'
require 'csv'
require 'date'

# Typecasts an Object to a DateTime
# Override the default for DION
#

class ScripUpdater
  DATA_SOURCES = {
    :nse => {
      :url       => "203.200.1.78",
      :username  => "inpreto",
      :password  => "sce9sodw",
      :directory => "nseeqde/#{Date.today.strftime('%Y%m%d')}"
    },
    :bse => {
      :url       => "203.200.1.78",
      :username  => "inpreto",
      :password  => "sce9sodw",
      :directory => "bse/#{Date.today.strftime('%Y%m%d')}"
    }
  }

  DATA_ATTRIBUTES = {
    :nse => {
      :id                => 1,
      :time              => 4,
      :last_traded_price => 5,
      :volume            => 14,
      :open_price        => 8,
      :high_price        => 6,
      :low_price         => 7,
      :close_price       => 18
    },
    :bse => {
      :id => 0,
      :bse_time => 1,
      :bse_last_traded_price => 2,
      :bse_high_price => 3,
      :bse_low_price => 4,
      :bse_open_price => 5,
      :bse_close_price => 6,
      :bse_volume => 11
    }
  }

  DATA_MODEL = {
    :bse => ScripBse,
    :nse => Scrip
  }

  def self.update_records
    DATA_SOURCES.keys.each do |index|
      records = self.fetch_data(index)
      records.shift # ignore the header
      records.each do |attributes|
        begin
          with_modified_datecaster do
            item = DATA_MODEL[index].find_or_initialize_by_id attributes.delete :id
            item.update_attributes(attributes)
          end
        rescue => ex
          Airbrake.notify ex
        end
      end
    end
  end

  def self.fetch_data(index)

    data = []
    Net::FTP.open(DATA_SOURCES[index][:url], DATA_SOURCES[index][:username], DATA_SOURCES[index][:password]) do |ftp|
      ftp.passive = true
      ftp.chdir DATA_SOURCES[index][:directory] if DATA_SOURCES[index][:directory]
      return data unless file_name = ftp.nlst.sort_by { |f| ftp.mtime f }.last
      ftp.gettextfile(file_name, nil) do |line|
        data << attributes_hash(CSV.parse_line(line), index)
      end
    end

    data
  end

private

  def self.with_modified_datecaster
    ActiveAttr::Typecasting::DateTimeTypecaster.class_eval do
      alias :old_call :call
      def call(value)
        DateTime.strptime value, "%m/%e/%Y %r"
      end
    end

    yield

    ActiveAttr::Typecasting::DateTimeTypecaster.class_eval do
      alias :call :old_call
    end
  end

  def self.attributes_hash(row, index)
    Hash[ DATA_ATTRIBUTES[index].map { |key, value| [key, row[value].strip] } ]
  end
end
