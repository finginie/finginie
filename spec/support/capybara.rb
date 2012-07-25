Capybara.javascript_driver = :webkit
unless ENV.member?('TDDIUM')
  HEADLESS = Headless.new
  HEADLESS.start
end

