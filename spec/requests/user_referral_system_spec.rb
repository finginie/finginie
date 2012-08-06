require 'spec_helper'

#TODO: Refactor this spec after finishing up ebola
describe "#UserReferralSystem" do
  context "on user registration" do
    it "should store referral data", :omniauth do
      referrer = create :user_with_profile
      comprehensive_risk_profiler = create :comprehensive_risk_profiler, :user => referrer
      visit public_financial_profile_path(referrer)
      current_user = create :user
      OmniAuth.config.add_mock 'single_signon', { :uid => current_user.id }

      #before user registration
      cp = CompletedStep.where(:user_id => referrer.id, :step_id => Step::REFERRAL).last
      cp.should be_nil

      visit '/auth/single_signon'

      #after user registration
      cp = CompletedStep.where(:user_id => referrer.id, :step_id => Step::REFERRAL).last
      cp.should_not be_nil
      cp.data['referred_user_id'].should eq current_user.id.to_s
    end

    context "Two users referred the same user" do
      it "should store first reffered user data", :omniauth do
        referrer1 = create :user_with_profile
        comprehensive_risk_profiler = create :comprehensive_risk_profiler, :user => referrer1
        visit public_financial_profile_path(referrer1)

        referrer2 = create :user_with_profile
        comprehensive_risk_profiler = create :comprehensive_risk_profiler, :user => referrer2
        visit public_financial_profile_path(referrer2)

        current_user = create :user
        OmniAuth.config.add_mock 'single_signon', { :uid => current_user.id }

        #before user registration
        cp = CompletedStep.where(:user_id => referrer1.id, :step_id => Step::REFERRAL).last
        cp.should be_nil

        visit '/auth/single_signon'

        #after user registration
        cp = CompletedStep.where(:user_id => referrer1.id, :step_id => Step::REFERRAL).last
        cp.should_not be_nil
      end
    end

    context "Already referred user" do #this might go to controller spec
      it "should not create referral data", :omniauth do
        referrer = create :user_with_profile
        comprehensive_risk_profiler = create :comprehensive_risk_profiler, :user => referrer
        visit public_financial_profile_path(referrer)
        current_user = create :user
        OmniAuth.config.add_mock 'single_signon', { :uid => current_user.id }

        create :completed_step, { :user_id => create(:user).id, :step_id => Step::REFERRAL, :data => { :referred_user_id => current_user.id } }

        visit '/auth/single_signon'
        cp = CompletedStep.where(:user_id => referrer.id, :step_id => Step::REFERRAL).last
        cp.should be_nil
      end
    end
  end
end