require 'spec_helper'

describe "Authentication" do
  it "should sign in using facebook" do
    visit '/auth/facebook'
    page.should have_content 'Successfully signed in'
  end

  pending "should sign in using gmail" do
    visit '/auth/google'
    page.should have_content 'Successfully signed in'
  end

  it "should redirect to signin page for the pages requiring authentication" do
    visit portfolios_path
    current_path.should eq signin_path
  end

  it "should go back to previous page after logging in" do
    visit portfolios_path
    click_button 'Facebook'
    current_path.should eq portfolios_path
  end
end
