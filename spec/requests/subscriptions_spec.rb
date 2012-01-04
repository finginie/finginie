require 'spec_helper'

describe "Subscriptions" do
  include_context "logged in user"
  let (:profile) { create :user, :with_profile }

  it "index should not display unrelated subscriptions" do
    subscription = create :user_subscription
    visit subscriptions_path
    page.should have_no_content subscription.subscribable.name
  end

  it "could be created by following a user" do
    visit profile_path profile
    click_button 'Follow'
    page.should have_content profile.name
    visit profile_path profile
    page.should have_no_button 'Follow'
    page.should have_button 'Unfollow'
  end

  it "could be deleted by unfollowing a user" do
    subscription = create :subscription, :user => current_user, :subscribable => profile
    visit profile_path profile
    click_button 'Unfollow'
    page.should have_no_content profile.name
    visit profile_path profile
    page.should have_no_button 'Unfollow'
    page.should have_button 'Follow'
  end

  it "could not be created for self" do
    visit own_profile_path
    page.should have_no_button 'Unfollow'
    page.should have_no_button 'Follow'
  end
end
