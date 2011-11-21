shared_context "logged in user" do
  let (:current_user) { Factory.create :user }
  before :each do
    visit new_user_session_path
    within "#user_new" do
      fill_in 'Password', :with => current_user.password
      fill_in 'Email', :with => current_user.email
      click_button 'Sign in'
    end
    wait_until(100) do
      page.should have_content("Signed in successfully")
    end
  end
end
