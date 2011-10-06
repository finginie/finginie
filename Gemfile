source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'compass', '~> 0.12.alpha.0'
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

gem 'airbrake'
gem 'cancan'
gem 'clearance_omniauth', :git => "git://github.com/LoonyBin/clearance_omniauth.git"
gem 'haml-rails'
gem 'inherited_resources'
gem 'jquery-rails'
gem 'nested_form', :git => "https://github.com/ryanb/nested_form.git"
gem 'paper_trail'
gem 'redis'
gem 'simple_form'

group :test, :development do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'spork', '>0.9.0.rc'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
  gem 'thin'
end
