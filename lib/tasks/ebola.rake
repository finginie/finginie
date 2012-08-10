namespace :ebola do
  task :add_points_to_existing_users => :environment do
    User.all.each do |user|
      PointTracker::SignUpStep.new(user).save
      PointTracker::FinancialProfileQuizStep.new(user).save
    end
  end
end
