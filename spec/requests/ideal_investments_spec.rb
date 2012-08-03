require 'spec_helper'

describe 'Ideal Investments',:mongoid do
  include_context "logged in user"

  let(:gold_etfs) { [ ['Goldman Sachs Gold Exchange Traded Scheme-Growth', 24.93 ],
                      ['SBI Gold Exchange Traded Scheme-Growth', '24.43' ],
                      ['Kotak Gold ETF-Growth', '25.50' ] ].map { |etf|
    create :'data_provider/scheme', :name => etf.first, :prev3_year_comp_percent => etf.last }
  }

  let(:banks) { [
        Bank.new(
            name:                      "Fixed Deposit at Karur Vysya Bank",
            sector:                    "PRIVATE",
            one_year_interest_rate:    10.0,
            six_month_interest_rate:   7.8,
            three_month_interest_rate: 7.8,
            one_month_interest_rate:   6.0
        ),
        Bank.new(
            name:                      "Fixed Deposit at Andhra Bank",
            sector:                    "PUBLIC",
            one_year_interest_rate:    9.4,
            six_month_interest_rate:   8.5,
            three_month_interest_rate: 7.25,
            one_month_interest_rate:   4.5
        )
    ]
  }

  let(:large_cap_schemes) { [ create(:'data_provider/scheme', :bench_mark_index_name => 'NSE Index',
                                :prev3_year_comp_percent => 22, :code => '14001200', :plan_code => '2066'),
                              create(:'data_provider/scheme', :bench_mark_index_name => 'BSE 100 Index',
                                  :prev3_year_comp_percent => 16, :code => '14001340', :plan_code => '2067') ] }

  let(:mid_cap_schemes) { [ create(:'data_provider/scheme', :bench_mark_index_name => 'CNX Midcap Index',
                              :prev3_year_comp_percent => 22, :code => '15002000', :plan_code => '2066'),
                              create(:'data_provider/scheme', :bench_mark_index_name => 'BSE Mid-Cap Index',
                                  :prev3_year_comp_percent => 16, :code => '15001200', :plan_code => '2067') ] }

  context "#Quiz is skipped" do
    before(:each) do
      current_user.comprehensive_risk_profiler.score_cache = 6
      current_user.comprehensive_risk_profiler.save(validate: false)
    end

    it "should have default gold investments on the page" do
      gold_etfs.each{ |scheme| scheme.save }

      visit comprehensive_risk_profiler_ideal_investments_path
      page.should have_content 'Ideal Investments'
      page.should have_content I18n.t('ideal_investments.investments.gold_investments')

      tableish("table[data-role='gold_investments']").should include [ gold_etfs.last.name, '9,000.00' ]
    end

    it "should have fixed deposits on the page" do

      visit comprehensive_risk_profiler_ideal_investments_path
      page.should have_content I18n.t('ideal_investments.investments.fixed_deposits')

      expected_content = banks.map { |bank| [ bank.name, '6,000.00' ] }
      tableish("table[data-role='fixed_deposits']").should include *expected_content
    end

    it "should have large caps on the page" do
      large_cap_schemes.each { |scheme| scheme.save }

      visit comprehensive_risk_profiler_ideal_investments_path
      page.should have_content I18n.t('ideal_investments.investments.large_caps')

      expected_content = large_cap_schemes.take(1).map { |scheme| [ scheme.name, '6,000.00' ] }
      tableish("table[data-role='large_caps']").should include *expected_content

    end

    it "should have mid caps on the page" do
      mid_cap_schemes.each { |scheme| scheme.save }

      visit comprehensive_risk_profiler_ideal_investments_path
      page.should have_content I18n.t('ideal_investments.investments.mid_caps')

      expected_content = mid_cap_schemes.take(1).map { |scheme| [ scheme.name, '3,000.00' ] }
      tableish("table[data-role='mid_caps']").should include *expected_content
    end

    it "should show top five ELSS funds on the page" do
      top_elss_funds = [ create(:'data_provider/scheme', :class_code => 2119, :prev3_year_comp_percent => 22),
                         create(:'data_provider/scheme', :class_code => 2119, :prev3_year_comp_percent => 21.2) ]

      visit comprehensive_risk_profiler_ideal_investments_path
      expected_content = [ [top_elss_funds.first.name, '22.00'],[top_elss_funds.last.name, '21.20'] ]
      tableish("table[data-role='top_elss_funds']").should include *expected_content
    end

  end

  context "#Quiz is answered" do
    before(:each) do
      current_user.comprehensive_risk_profiler.update_attributes(
        :age                      => 25,
        :household_savings        => 200000,
        :household_income         => 60000,
        :household_expenditure    => 35000,
        :dependent                => 3,
        :tax_saving_investment    => 100,
        :special_goals_amount     => 2000000,
        :special_goals_years      => 5,
        :preference               => 6,
        :portfolio_investment     => 5,
        :time_horizon             => 4 )
    end

    it "should have gold investemnts" do
      gold_etfs.each{ |scheme| scheme.save }
      visit comprehensive_risk_profiler_ideal_investments_path

      tableish("table[data-role='gold_investments']").should include([ gold_etfs.last.name, '19,500.00' ],
          [ gold_etfs.first.name, '19,500.00' ])
    end

    it "should have public financial profile page link" do
      visit comprehensive_risk_profiler_ideal_investments_path
      page.should have_content I18n.t('ideal_investments.show.public.profile_link')
    end

    it "should have fixed deposits" do
      visit comprehensive_risk_profiler_ideal_investments_path
      page.should have_content I18n.t('ideal_investments.investments.fixed_deposits')

      expected_content = banks.map { |bank| [ bank.name, '19,500.00' ] }
      tableish("table[data-role='fixed_deposits']").should include *expected_content

    end

    it "should have large caps on the page" do
      large_cap_schemes.each { |scheme| scheme.save }

      visit comprehensive_risk_profiler_ideal_investments_path
      page.should have_content I18n.t('ideal_investments.investments.large_caps')

      expected_content = large_cap_schemes.map { |scheme| [ scheme.name, '13,000.00' ] }
      tableish("table[data-role='large_caps']").should include *expected_content
    end

    it "should have mid caps on the page" do
      mid_cap_schemes.each { |scheme| scheme.save }

      visit comprehensive_risk_profiler_ideal_investments_path
      page.should have_content I18n.t('ideal_investments.investments.mid_caps')

      expected_content = mid_cap_schemes.map { |scheme| [ scheme.name, '13,000.00' ] }
      tableish("table[data-role='mid_caps']").should include *expected_content
    end

    it "should give a form to enter the initial investment" do
      visit comprehensive_risk_profiler_ideal_investments_path
      fill_in 'initial_investment', :with => 45000
      click_on I18n.t('ideal_investments.show.submit')

      expected_content = banks.map { |bank| [ bank.name, '6,750.00' ] }
      tableish("table[data-role='fixed_deposits']").should include *expected_content
    end

    it "should have continue button linked to trade page" do
      visit comprehensive_risk_profiler_ideal_investments_path
      page.should have_link 'Continue'
      click_on 'Continue'
      page.current_path.should eq page_path('trade')
    end

  end

end
