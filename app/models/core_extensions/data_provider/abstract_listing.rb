module AbstractListing
  extend ActiveSupport::Concern

  included do
    scope :nifty, where(:exchange_group => 'Nifty')
  end
end

DataProvider::Listing.class_eval do include AbstractListing; end
