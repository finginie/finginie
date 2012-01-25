shared_context "logged in user" do
  let (:current_user) { Factory.create :user }
  before :each do |example|
    pending "Add omniauth to authenticate"
  end
end
