module DeviseMacros
  def login_admin
    before :each do
      user = Factory.create(:admin)
      page.driver.post admin_user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
    end
  end

  def login_user
    before :each do
      user = Factory.create(:user)
      page.driver.post user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
    end
  end
end
