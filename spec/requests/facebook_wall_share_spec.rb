require 'spec_helper'

describe "Facebook Wall share" do
  context "Logged in user and user has taken quiz" do
    include_context "logged in user"
    let(:comprehensive_risk_profiler) { create :comprehensive_risk_profiler, :user => current_user }

    context "clicked on facebook share button" do
      context "when logged in to facebook" do
        it "should have public share link in the facebook share dialog page", :mechanize, :vcr do
          comprehensive_risk_profiler.save

          visit comprehensive_risk_profiler_ideal_investments_path

          click_on I18n.t('ideal_investments.show.facebook.post_wall')
          fill_in 'email', :with => 'max.cracker@gmail.com'
          fill_in 'pass', :with => 'maxcrackermax'
          click_on 'Log In'
          click_on 'Share'
          page.should have_content I18n.t('comprehensive_risk_profilers.public.facebook.success_message')
        end
      end
    end

  end
end
