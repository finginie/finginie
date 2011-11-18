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

end
