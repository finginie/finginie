Capybara.javascript_driver = :webkit
unless ENV.member?('TDDIUM')
  headless = Headless.new
  headless.start
end

RSpec.configure do |c|
  c.before(:each, :js) do |example|
    # Use shared connection with transactional fixtures
    class ActiveRecord::Base
      mattr_accessor :shared_connection
      @@shared_connection = nil

      def self.connection
        @@shared_connection || retrieve_connection
      end
    end

    # Forces all threads to share the same connection. This works on
    # Capybara because it starts the web server in a thread.
    ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
  end
end
