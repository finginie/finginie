require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

RSpec.configure do |c|
  c.before(:each, :mechanize) do |example|
    Capybara.current_driver = :mechanize
  end
end
