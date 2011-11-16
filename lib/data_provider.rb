require 'clockwork'
require File.expand_path('../../config/environment', __FILE__)

include Clockwork

handler do |job|
  case job
  when 'news'
    NewsData.store_feeds
  when 'ticker'
    TickerData.store_indices
  else
    TickerPlant.update_records(job.to_sym)
  end
  # TODO: Stop clockwork if job == :stock
end

every 1.minute, 'ticker'
every 10.minutes, 'news'
every 1.minute, 'scrip'
every 1.day, 'stock', :at => '16:30'
