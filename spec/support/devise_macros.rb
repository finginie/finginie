Devise.stretches = 1

shared_context "logged in user" do
  let (:current_user) { Factory.create :user }
  before :each do
    # Login here
  end
end
