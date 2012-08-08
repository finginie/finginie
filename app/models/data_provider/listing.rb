require File.expand_path('../../../../engines/data_provider/lib/data_provider/listing.rb', __FILE__)

module DataProvider
	class Listing
    scope :nifty, where(:exchange_group => 'Nifty')
  end
end
