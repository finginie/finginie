require 'spec_helper'

describe "Authorization" do
  it "should redirect to signin page for the pages requiring authentication" do
    visit portfolios_path
    current_path.should eq new_user_session_path
  end

  it "should go back to previous page after logging in" do
    user = Factory.create :user
    visit portfolios_path
    within "#user_new" do
      fill_in 'Password', :with => user.password
      fill_in 'Email', :with => user.email
      click_button 'Sign in'
    end
    current_path.should eq portfolios_path
  end
end
