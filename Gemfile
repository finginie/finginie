source 'http://rubygems.org'

gem 'rails', '3.2.6'

# Unbuilt gems from the project modules
#
gem 'personal_financial_tools', :path => 'engines/personal_financial_tools'
gem 'data_provider',            :path => 'engines/data_provider'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'uglifier'
  gem 'jquery-ui-rails'
end

gem 'active_attr', :git => 'git://github.com/sankaranarayanan/active_attr.git'
gem 'airbrake'
gem 'bourbon'
gem 'cancan'
gem 'cells'
gem 'dimensions-rails'
gem 'draper'
gem 'dynamic_sitemaps'
gem 'haml-rails'
gem 'high_voltage'
gem 'inherited_resources'
gem 'jquery-datatables-rails', git: "git://github.com/rweng/jquery-datatables-rails.git"
gem 'jquery-rails'
gem 'kaminari'
gem 'meta_search'
gem 'mongoid' # Required by mongoid search
gem 'mongoid_search', :git => "git://github.com/mauriciozaffari/mongoid_search.git"
gem 'nested_form', :github => 'TMaYaD/nested_form'
gem 'newrelic_rpm'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'paper_trail'
gem 'pg'
gem 'rack-environmental'
gem 'sheet_mapper', :github => 'TMaYaD/sheet_mapper'
gem 'simple_form', :git => "git://github.com/plataformatec/simple_form.git"
gem 'simple-navigation'
gem 'thin'

group :test, :development do
  gem 'brakeman'
  gem 'capybara'
  gem 'capybara-webkit'
    gem 'headless'
  gem "rspec-cells"
  gem 'factory_girl_rails'
  gem 'foreman'
  gem 'guard'
    gem 'growl', :require => false
    gem 'libnotify'
    gem 'rb-inotify', :require => false
    gem 'rb-fsevent', :require => false
  gem 'guard-bundler'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'heroku_san'
  gem 'pry'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false
  gem 'spork'
  gem 'tddium'
  gem 'timecop'
end

group :development do
  gem 'heroku'
  gem 'rails_best_practices'
  gem 'rails-footnotes', '>= 3.7.5.rc4'
end

group :test do
  gem 'vcr'
    gem 'webmock'
end
