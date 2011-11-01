require 'clockwork'

include Clockwork

handler do |job|
  TickerPlant.update(job)
  # TODO: Stop clockwork if job == :stock
end

every 1.minute, :scrip
every 1.day, :stock, :at => '16:30'
