require 'spec_helper'

describe "FinancialPlanner" do
  describe "GET /financial_planner" do
    it "lists all the profilers available" do
      create :quiz, :name => 'Investing Behaviour Profile'
      visit financial_planner_path
      page.should have_link 'Investing Behaviour Profile'
    end
  end
end
