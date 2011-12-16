source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails'
  gem 'compass', '~> 0.12.alpha.0'
  gem 'sass-rails'
  gem 'uglifier'
end

gem 'activeadmin', :git => "git://github.com/TMaYaD/active_admin.git"
  gem 'sass-rails' # stupid activeadmin needs this
  gem 'compass', '~> 0.12.alpha.0' # and sass requires this
gem 'airbrake'
gem 'cancan'
gem 'clockwork'
gem 'devise'
gem 'draper'
gem 'feedzirra'
gem 'haml-rails'
gem 'high_voltage'
gem 'inherited_resources'
gem 'jquery-rails'
gem 'kaminari'
gem 'meta_search'
gem 'nested_form', :git => "git://github.com/vikashag/nested_form.git"
gem 'paper_trail'
gem 'rails-backbone', :git => "git://github.com/TMaYaD/backbone-rails.git", :branch => "patch-1"
gem 'redis'
gem 'simple_form'
gem 'simple-navigation'
gem 'thin'
gem 'valuable', :git => "git://github.com/LoonyBin/valuable.git"
gem 'zipruby'

group :test, :development do
  gem 'capybara'
    gem 'rubyzip', :git => "git://github.com/FinGinie/rubyzip.git" # Fix scoping issues
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'foreman'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'libnotify'
  gem 'pry'
  gem 'rb-inotify'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'spork', '>0.9.0.rc'
  gem 'sqlite3'
  gem 'tddium-preview'
  gem 'timecop'
end

group :development do
  gem 'heroku'
  gem 'rails_best_practices'
end

group :tddium do
  gem 'tddium'
end

group :production do
  gem 'pg'
  gem 'thin'
end
