$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "personal_financial_tools/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "personal_financial_tools"
  s.version     = PersonalFinancialTools::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of PersonalFinancialTools."
  s.description = "TODO: Description of PersonalFinancialTools."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.3"
  s.add_dependency "active_attr"
  s.add_dependency "haml-rails"
  s.add_dependency "simple_form"
  s.add_dependency "nested_form"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "capybara"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "shoulda-matchers"
end
