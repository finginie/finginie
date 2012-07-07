shared_context "logged in user" do
  let (:current_user) { create :user }
  before :each do |example|
    current_user.save
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock 'single_signon', { :uid => current_user.id }
    visit '/auth/single_signon'
  end

  after(:each) do |example|
    OmniAuth.config.test_mode = false
  end
end
