require 'rubygems'
require 'spork'

Spork.prefork do
  unless ENV['DRB']
    require 'simplecov'
  end

  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'

  # Allow sheet mapper to login during initialization
  require 'webmock'
  WebMock.allow_net_connect!

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  WebMock.disable_net_connect!

  RSpec.configure do |config|
    config.treat_symbols_as_metadata_keys_with_true_values = true
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec

    # mix factory girl
    config.include FactoryGirl::Syntax::Methods
    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # Use the fail_fast option to tell RSpec to abort the run on first failure.
    # config.fail_fast = true
  end

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

end

Spork.each_run do
  if ENV['DRB']
    require 'simplecov'
  end

  # Import factories from data provider
  FactoryGirl.definition_file_paths << File.expand_path('../../engines/data_provider/spec/factories', __FILE__)
  FactoryGirl.reload

  # This code will be run each time you run your specs.
end
