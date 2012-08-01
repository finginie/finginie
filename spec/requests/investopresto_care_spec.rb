require 'spec_helper'

describe "Finginie Care" do
  context "#page" do
    before(:each) do
      visit page_path('finginie-cares')
    end

    it "should goto ideal investment mix after signin", :omniauth, :js do
      # omniauth signin
      page.current_path.should eq edit_comprehensive_risk_profiler_path
    end

    it "should display special offer message", :omniauth, :js do
      page.should have_content I18n.t('special_offer.message')
    end
  end

end
