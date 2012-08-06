require 'spec_helper'

describe UserAccount do
  let(:user) { create :user }
  let(:user_account) { UserAccount.new(user) }
  let(:session) { {} }

  context '#success_callback' do

    context "when financial profile data in session" do
      let(:session) { { :comprehensive_risk_profiler => attributes_for(:comprehensive_risk_profiler) } }

      it "should create comprehensive_risk_profiler for given user" do
        lambda { user_account.success_callback(session) }.should change(ComprehensiveRiskProfiler, :count).by(1)
      end

      it "should not create comprehensive_risk_profiler if given user has comprehensive_risk_profiler already" do
        comprehensive_risk_profiler = create :comprehensive_risk_profiler, :user => user
        lambda { user_account.success_callback(session) }.should change(ComprehensiveRiskProfiler, :count).by(0)
      end

      it "should create invalid comprehensive_risk_profiler for given user with only score" do
        session[:score_cache] = 6
        lambda { user_account.success_callback(session) }.should change(ComprehensiveRiskProfiler, :count).by(1)
      end
    end

    context "when financial profile data is not in session" do
      it "should not create comprehensive_risk_profiler data for given user" do
        lambda { user_account.success_callback(session) }.should change(ComprehensiveRiskProfiler, :count).by(0)
      end
    end

    it "should create signup completed step for registered user" do
      sign_up_completed_step = user.completed_sign_up_step?
      sign_up_completed_step.should_not be
      user_account.success_callback(session)
      sign_up_completed_step = user.completed_sign_up_step?
      sign_up_completed_step.should be
    end

    pending "For Registered User#" do
      context "Given user is refferred" do
        let(:referrer) { create :user }
        let(:session) { { :referrer_id => referrer.id } }

        it "should create REFERRAL_STEP completed step for refferred user" do
          referral_completed_step = referrer.completed_referral_step?
          referral_completed_step.should_not be
          user_account.success_callback(session)
          referral_completed_step = referrer.completed_referral_step?
          referral_completed_step.should be
        end

        it "should store refferred user data in completed_steps table" do
          user_account.success_callback(session)
          referral_completed_step = referrer.completed_referral_step
          referral_completed_step.data['referred_user_id'].should == user.id.to_s
        end

        pending "should not create completed_step for user if registered user is already referred" do
          referred_user = create :user
          CompletedStep.create({ :user_id => referrer.id, :step_id => Step::REFERRAL, :data => { :referred_user_id => referred_user.id } })
          puts CompletedStep.where("data -> 'referred_user_id' = '#{referred_user.id}'").count
          user_account.success_callback(session)
          # Person.where("data -> 'foo' = 'bar'")
          puts CompletedStep.where("data -> 'referred_user_id' = '#{referred_user.id}'").count
        end
      end

      context "Given user is not referred" do
        it "should not create REFERRAL_STEP completed step for refferred user" do
          user_account.success_callback(session)
          cp = CompletedStep.find_by_step_id(Step::REFERRAL)
          cp.should be_nil
        end
      end
    end
  end
end