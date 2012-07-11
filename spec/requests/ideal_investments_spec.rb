require 'spec_helper'

describe 'Ideal Investemnts' do
  include_context "logged in user"

  it "should have default ideal investments on the page" do
    current_user.comprehensive_risk_profiler.score_cache = 6
    current_user.comprehensive_risk_profiler.save(validate: false)

    create :'data_provider/scheme', :name => 'Goldman Sachs Gold Exchange Traded Scheme-Growth',
                                    :class_description => 'Special Fund', :prev3_year_comp_percent => 25.45
    create :'data_provider/scheme', :name => 'SBI Gold Exchange Traded Scheme-Growth',
                                    :class_description => 'Special Fund', :prev3_year_comp_percent => 25.34
    create :'data_provider/scheme', :name => 'Kotak Gold ETF-Growth',
                                    :class_description => 'Special Fund', :prev3_year_comp_percent => 25.50

    visit comprehensive_risk_profiler_ideal_investments_path
    page.should have_content 'Ideal Investments'

    tableish("table").should include [ 'Kotak Gold ETF-Growth', '9,000.00' ]
  end

end
