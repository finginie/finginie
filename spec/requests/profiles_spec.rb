require 'spec_helper'

describe "Profiles" do
  include_context "logged in user"
  let(:current_user) { create :user, :name => 'Neo', :location => 'Zion', :occupation => 'The One', :company => 'Nebuchadnezzar' }
  let(:profile) { create :user, :name => 'Smith', :location => '01', :occupation => 'Agent', :company => 'Matrix' }

  before(:each) do
    profile.save
    current_user.save
  end

  it "lists all the users' names, cities and avatars" do
    visit profiles_path
    page.should have_content 'Neo'
    page.should have_content 'Zion'
    page.should have_content 'Smith'
    page.should have_content '01'
  end

  it "shows details of a user" do
    visit profile_path profile
    page.should have_content 'Smith'
    page.should have_content '01'
    page.should have_content 'Agent'
    page.should have_content 'Matrix'
    page.should have_no_link 'Edit'
  end

  it "shows details of the current user" do
    visit own_profile_path
    page.should have_content 'Neo'
    page.should have_content 'Zion'
    page.should have_content 'The One'
    page.should have_content 'Nebuchadnezzar'
    page.should have_link 'Edit'
  end

  it "can be edited by the owner" do
    visit edit_own_profile_path
    fill_in 'Name', :with => "Anderson"
    click_button 'Update User'
    page.should have_content 'successfully'
    page.should have_content 'Anderson'
    page.should have_no_content 'Neo'
  end

  it "can not be edited by anyone except owner", :js do
    visit edit_own_profile_path
    fill_in 'Name', :with => "Suit"
    page.execute_script("$('form.user').prepend('<input id=id name=id value=#{profile.id} />')")
    click_button 'Update User'
    visit profile_path profile
    page.should have_no_content 'Suit'
  end

  it "should be searchable by name" do
    visit profiles_path
    fill_in :name_contains, :with => 'mith'
    click_button 'Search'
    page.should have_content 'Smith'
    page.should have_no_content 'Neo'
  end
end
