module DeviseMacros
  def login_admin
    before :each do
      user = Factory.create(:admin)
      page.driver.post admin_user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
    end
  end

  def login_user
    let(:user) { Factory.create :user }
    before :each do
      visit new_user_session_path
      within "#user_new" do
        fill_in 'Password', :with => user.password
        fill_in 'Email', :with => user.email
        click_button 'Sign in'
      end
      wait_until(100) do
        page.should have_content("Signed in successfully")
      end
    end
  end
end
