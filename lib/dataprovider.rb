require 'clockwork'
require File.expand_path('../../config/environment', __FILE__) 

include Clockwork

handler do |job|
  TickerPlant.data(job).each do |attributes|
    send("save_#{job.to_s}_data", attributes)
  end
  # TODO: Stop clockwork if job == :eod
end

every 1.minute, :scrip
every 1.day, :eod, :at => '16:30'

def save_scrip_data(attributes)
  id = attributes.delete(:id)
  stock_quote = StockQuote.find(id) || StockQuote.new
  stock_quote.update_attributes(attributes).save
end

def save_eod_data(attributes)
  id = attributes.delete(:id)
  Stock.find_or_initialize_by_id(id).update_attributes(attributes)
end
