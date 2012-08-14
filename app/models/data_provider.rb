require 'core_extensions/data_provider/abstract_listing'
require 'core_extensions/data_provider/abstract_company'
require 'core_extensions/data_provider/scheme_extensions'

module DataProvider
  autoload :Company,  File.expand_path('../data_provider/company.rb', __FILE__)
  autoload :Listing,  File.expand_path('../data_provider/listing.rb', __FILE__)
  autoload :Scheme,  File.expand_path('../data_provider/Scheme.rb', __FILE__)
end
