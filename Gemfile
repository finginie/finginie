source 'http://rubygems.org'

gem 'rails', '3.2.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'uglifier'
end

gem 'airbrake'
gem 'bourbon', :git => "git://github.com/FinGinie/bourbon.git"
gem 'bson_ext'
gem 'cancan'
gem 'copycopter_client'
gem 'draper', :git => "git://github.com/jcasimir/draper.git"
gem 'feedzirra'
gem 'haml-rails'
gem 'high_voltage'
gem 'inherited_resources'
gem 'jquery-rails'
gem 'kaminari'
gem 'meta_search'
gem 'mongoid'
  gem 'bson_ext'
gem 'mongoid_search'
gem 'nested_form', :git => "git://github.com/TMaYaD/nested_form.git"
gem 'newrelic_rpm'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'paper_trail'
gem 'pinch'
gem 'rails-backbone', :git => "git://github.com/TMaYaD/backbone-rails.git"
gem 'redis'
gem 'simple_form'
gem 'simple-navigation'
gem 'thin'
gem 'valuable', :git => "git://github.com/LoonyBin/valuable.git"
gem 'zipruby'

group :test, :development do
  gem 'capybara'
    gem 'rubyzip', :git => "git://github.com/FinGinie/rubyzip.git" # Fix scoping issues
  gem 'capybara-webkit'
    gem 'headless', :git => "git://github.com/LoonyBin/headless.git" # https://github.com/leonid-shevtsov/headless/pull/22
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'foreman'
  gem 'guard'
    gem 'growl', :require => false
    gem 'libnotify'
    gem 'rb-inotify', :require => false
    gem 'rb-fsevent', :require => false
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'pry'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'spork'
  gem 'sqlite3'
  gem 'tddium'
  gem 'timecop'
end

group :development do
  gem 'heroku'
  gem 'rails_best_practices'
end

group :test do
  gem 'vcr', '~>2.0.0.rc1'
    gem 'webmock'
end

group :production do
  gem 'pg'
  gem 'thin'
end
