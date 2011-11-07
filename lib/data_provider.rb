require 'clockwork'
require File.expand_path('../../config/environment', __FILE__)

include Clockwork

handler do |job|
  TickerPlant.update_records(job)
  # TODO: Stop clockwork if job == :stock
end

every 1.minute, :scrip
every 1.day, :stock, :at => '16:30'
