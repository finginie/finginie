require 'net/ftp'
require 'csv'
require 'date'

# Typecasts an Object to a DateTime
# Override the default for DION
#

class ScripUpdater
  DATA_SOURCES = {
    :url       => "203.200.1.78",
    :username  => "inpreto",
    :password  => "sce9sodw",
    :directory => "nseeqde/#{Date.today.strftime('%Y%m%d')}"
  }

  DATA_ATTRIBUTES = {
    :id                => 1,
    :time              => 4,
    :last_traded_price => 5,
    :volume            => 14,
    :open_price        => 8,
    :high_price        => 6,
    :low_price         => 7,
    :close_price       => 18
  }

  def self.update_records
    records = self.fetch_data
    records.shift # ignore the header
    records.each do |attributes|
      begin
        with_modified_datecaster do
          item = Scrip.find_or_initialize_by_id attributes.delete :id
          item.update_attributes(attributes)
        end
      rescue => ex
        Airbrake.notify ex
      end
    end
  end

  def self.fetch_data
    data = []
    Net::FTP.open(DATA_SOURCES[:url], DATA_SOURCES[:username], DATA_SOURCES[:password]) do |ftp|
      ftp.passive = true
      ftp.chdir DATA_SOURCES[:directory] if DATA_SOURCES[:directory]
      return data unless file_name = ftp.nlst.sort_by { |f| ftp.mtime f }.last
      ftp.gettextfile(file_name, nil) do |line|
        data << attributes_hash(CSV.parse_line line)
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

  def self.attributes_hash(row)
    Hash[ DATA_ATTRIBUTES.map { |key, value| [key, row[value].strip] } ]
  end
end
