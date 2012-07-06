require 'spec_helper'

describe 'Ideal Investemnts' do
  include_context "logged in user"

  let(:comprehensive_risk_profiler) { create :comprehensive_risk_profiler, :user => current_user }

  it "should have default ideal investments on the page" do
    visit comprehensive_risk_profiler_ideal_investments_path
    page.should have_content 'Ideal Investments'
  end

end
