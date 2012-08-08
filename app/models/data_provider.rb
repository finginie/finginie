require 'data_provider'

module DataProvider
  autoload :Company,  File.expand_path('../data_provider/company.rb', __FILE__)
  autoload :Listing,  File.expand_path('../data_provider/listing.rb', __FILE__)
end
