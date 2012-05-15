OmniAuth.config.test_mode = true

shared_context "logged in user" do
  let (:current_user) { create :user }
  let (:authentication) { create :authentication, :user => current_user }
  before :each do |example|
    OmniAuth.config.add_mock authentication.provider, { :uid => authentication.uid }
    visit '/auth/finginie'
  end
end
