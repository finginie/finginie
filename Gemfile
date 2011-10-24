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

gem 'activeadmin', :git => "git://github.com/TMaYaD/active_admin.git"
gem 'sass-rails' # stupid activeadmin needs this
gem 'compass', '~> 0.12.alpha.0' # and sass requires this
gem 'airbrake'
gem 'cancan'
gem 'haml-rails'
gem 'inherited_resources'
gem 'jquery-rails'
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
  gem 'libnotify'
  gem 'pry'
  gem 'rb-inotify'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'spork', '>0.9.0.rc'
  gem 'sqlite3'
  gem 'tddium-preview'
end

group :development do
  gem 'heroku'
end

group :production do
  gem 'pg'
end
