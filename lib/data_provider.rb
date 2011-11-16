require 'clockwork'
require File.expand_path('../../config/environment', __FILE__)

include Clockwork

handler do |job|
  NewsData.store_feeds and return if job == :news
  TickerPlant.update_records(job)
  TickerData.store_indices and return if job == :ticker
  # TODO: Stop clockwork if job == :stock
end

every 1.minute, :ticker
every 10.minutes, :news
every 1.minute, :scrip
every 1.day, :stock, :at => '16:30'
