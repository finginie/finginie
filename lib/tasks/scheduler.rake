desc "This task is called by the Heroku scheduler add-on"

namespace :scheduler do

  desc "This task fetch news data and runs every 10 min"
  task :news => :environment do
    NewsData.store_feeds
  end

  desc "This task Ticker data and runs every 1 min"
  task :ticker => :environment do
    TickerData.store_indices
  end

  desc "This task scrip stock data and runs every 1 min"
  task :scrip => :environment do
    TickerPlant.update_records(:scrip)
  end

  desc "This task for stock data and runs every day"
  task :stock => :environment do
    TickerPlant.update_records(:stock)
  end
end

