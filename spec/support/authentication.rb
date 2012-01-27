OmniAuth.config.test_mode = true

shared_context "logged in user" do
  let (:current_user) { Factory.create :user }
  let (:authentication) { Factory.create :authentication, :user => current_user }
  before :each do |example|
    OmniAuth.config.add_mock authentication.provider, { :uid => authentication.uid }
    visit '/auth/facebook'
  end
end
