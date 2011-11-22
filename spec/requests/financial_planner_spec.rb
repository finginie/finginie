require 'spec_helper'

describe "FinancialPlanner" do
  include_context "logged in user"

  it "lists all the profilers available and take you to profiling page when clicked" do
    create :quiz, :name => 'Investing Behaviour Profile'
    visit financial_planner_path
    page.should have_link 'Investing Behaviour Profile'
    click_link 'Investing Behaviour Profile'
    page.should have_content 'Investing Behaviour Profile'
  end

  it "should have a message to complete quiz to get score" do
    create :quiz, :name => 'test quiz'
    visit financial_planner_path
    page.should have_content 'Complete this quiz to view your score'
  end

  describe "Financial Planner with risk_profilers saved " do

    let(:financial_planner) { create :financial_planner, :user => current_user }

    subject{ financial_planner }

    it "should show the score on page if quiz is answered" do
      2.times { |i| create :risk_profiler, :score => i+3, :financial_planner => financial_planner, :quiz => (
                    create :quiz,:name => "fin_planner_quiz#{i}", :weight => 4+i, :number_of_questions => 2, :number_of_choices_per_question => 3) }
      visit financial_planner_path
      page.should have_content "3"
      page.should have_content "4"
    end

    it "should show the corresponding asset allocation",:js => true do
      2.times { |i| create :risk_profiler, :score => i+3, :financial_planner => financial_planner, :quiz => (
                    create :quiz,:name => "fin_planner_quiz#{i}", :weight => 4+i, :number_of_questions => 2, :number_of_choices_per_question => 3) }
      visit financial_planner_path
      page.should have_content "Govt Securities: 20%"
      page.should have_content "Corporate Bonds: 25%"
    end

    it "should take the willingness_to_take_risk and show asset allocation",:js => true do
      2.times { |i| create :risk_profiler, :score => i+3, :financial_planner => financial_planner, :quiz => (
                    create :quiz,:name => "fin_planner_quiz#{i}", :weight => 4+i, :number_of_questions => 2, :number_of_choices_per_question => 3) }
      visit financial_planner_path
      fill_in "Willingness", :with => "3"
      click_button 'Submit'
      page.should have_content "Govt Securities: 30%"
      page.should have_content "Corporate Bonds: 20%"
    end
  end

end
