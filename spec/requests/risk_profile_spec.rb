require 'spec_helper'

describe "RiskProfile" do
  describe "GET /risk_profile" do
    it "lists all the profilers available" do
      create :quiz, :name => 'Investing Behaviour Profile'
      visit risk_profile_path
      page.should have_link 'Investing Behaviour Profile'
    end
  end
end
