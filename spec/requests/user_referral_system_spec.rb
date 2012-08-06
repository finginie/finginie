require 'spec_helper'

describe "#UserReferralSystem" do
  context "on user registration" do
    it "should store referral data", :omniauth do
      referrer = create :user_with_profile
      visit_public_financial_profile_of_a_user(referrer)

      current_user = create :user
      OmniAuth.config.add_mock 'single_signon', { :uid => current_user.id }
      #before user registration
      referrer.should_not be_completed_referral_step
      visit '/auth/single_signon'
      #after user registration
      referrer.should be_completed_referral_step
      cp = CompletedStep.where(:user_id => referrer.id, :step_id => Step::REFERRAL).last
      cp.data['referred_user_id'].should eq current_user.id.to_s
    end

    context "Two users referred the same user" do
      it "should store first reffered user data", :omniauth do
        first_referrer = create :user_with_profile
        visit_public_financial_profile_of_a_user(first_referrer)

        next_referrer = create :user_with_profile
        visit_public_financial_profile_of_a_user(next_referrer)

        current_user = create :user
        OmniAuth.config.add_mock 'single_signon', { :uid => current_user.id }
        #before user registration
        first_referrer.should_not be_completed_referral_step
        visit '/auth/single_signon'
        #after user registration
        first_referrer.should be_completed_referral_step
        next_referrer.should_not be_completed_referral_step
      end
    end

    context "Already referred user" do
      it "should not create referral data", :omniauth do
        referrer = create :user_with_profile
        visit_public_financial_profile_of_a_user(referrer)

        current_user = create :user
        OmniAuth.config.add_mock 'single_signon', { :uid => current_user.id }

        create :completed_step, { :user_id => create(:user).id, :step_id => Step::REFERRAL, :data => { :referred_user_id => current_user.id } }

        visit '/auth/single_signon'
        referrer.should_not be_completed_referral_step
      end
    end
  end

  def visit_public_financial_profile_of_a_user(user)
    comprehensive_risk_profiler = create :comprehensive_risk_profiler, :user => user
    visit public_financial_profile_path(user)
  end
end