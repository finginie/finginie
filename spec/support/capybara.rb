Capybara.javascript_driver = :webkit
unless ENV.member?('TDDIUM')
  HEADLESS = Headless.new
  HEADLESS.start
end

RSpec.configure do |c|
  c.before(:each, :mechanize) do |example|
    Capybara.current_driver = :mechanize
  end
end
