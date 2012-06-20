OmniAuth.config.test_mode = true

shared_context "logged in user" do
  let (:current_user) { create :user }
  before :each do |example|
    OmniAuth.config.add_mock 'finginie', { :uid => current_user.id }
    visit '/auth/finginie'
  end
end
