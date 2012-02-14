desc "This task is called by the Heroku scheduler add-on"
namespace :scheduler do
  desc "This task scrip stock data and runs every 1 min"
  task :scrip => :environment do
    TickerPlant.update_records(:scrip) if Time.now.hour >= 9 && Time.now.hour < 17
  end

  desc "This task for stock data and runs every day"
  task :stock => :environment do
    TickerPlant.update_records(:stock)
  end
end

