require 'spec_helper'

describe "Authorization" do
  it "should redirect to signin page for the pages requiring authentication" do
    visit portfolios_path
    uri = URI.parse(current_url)
    "#{uri.path}".should eq new_user_session_path
  end

  it "should go back to previous page after logging in",:js => true do
    user = Factory.create :user
    visit portfolios_path
    within "#user_new" do
        fill_in 'Password', :with => user.password
        fill_in 'Email', :with => user.email
        click_button 'Sign in'
      end
    wait_until(100) do
        page.should have_content("Signed in successfully")
    end
    uri = URI.parse(current_url)
    "#{uri.path}".should eq portfolios_path
  end

  it "should redirect to signin page for financial planner page" do
    visit financial_planner_path
    uri = URI.parse(current_url)
    "#{uri.path}".should eq new_user_session_path
  end

  it "should redirect to signin page for risk profiler page " do
    quiz = create :quiz, :name => "authorization test Quiz"
    visit financial_planner_risk_profiler_path(:id => quiz.slug)
    uri = URI.parse(current_url)
    "#{uri.path}".should eq new_user_session_path
  end

  it "should go to financial planner page after user logs in" do
    user = Factory.create :user
    visit financial_planner_path
    within "#user_new" do
        fill_in 'Password', :with => user.password
        fill_in 'Email', :with => user.email
        click_button 'Sign in'
      end
    wait_until(100) do
        page.should have_content("Signed in successfully")
    end
    uri = URI.parse(current_url)
    "#{uri.path}".should eq financial_planner_path
  end

  it "should go to risk profiler page after user logs in", :js =>true do
    user = Factory.create :user
    quiz = create :quiz, :name => 'authorization test quiz'
    visit new_user_session_path
    within "#user_new" do
        fill_in 'Password', :with => user.password
        fill_in 'Email', :with => user.email
        click_button 'Sign in'
      end
    wait_until(100) do
        page.should have_content("Signed in successfully")
    end
    visit financial_planner_risk_profiler_path(:id => quiz.slug)
    page.should have_content 'authorization test quiz'
  end

end
