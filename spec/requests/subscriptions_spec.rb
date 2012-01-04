require 'spec_helper'

describe "Subscriptions" do
  include_context "logged in user"
  let (:profile) { create :user, :with_profile }

  it "index should not display unrelated subscriptions" do
    subscription = create :user_subscription
    visit subscriptions_path
    page.should have_no_content subscription.subscribable.name
  end

  pending "could be created by following a user", :js do
    visit profile_path profile
    click_button 'Follow'
    page.should have_content profile.name
    visit profile_path profile
    page.should have_no_button 'Follow'
    page.should have_button 'Unfollow'
  end
end
