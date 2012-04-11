desc "This task is called by the Heroku scheduler add-on"
namespace :scheduler do
  desc "This task scrip stock data and runs every 1 min"
  task :scrip => :environment do
    ScripUpdater.update_records if Time.now.hour >= 9 && Time.now.hour < 17
  end

  desc "This task is for Corporate& Mutual fund Data and runs three times a day at 9.30 am, 1 pm, 11 pm"
  task :corporate_and_mutual_funds_data => :environment do
    CorporateInformationData.update_data
  end
end
