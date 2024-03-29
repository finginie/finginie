require 'spec_helper'

describe IdealInvestmentMix, :mongoid do
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

  let(:gold_etfs) { [ ['Goldman Sachs Gold Exchange Traded Scheme-Growth', 24.93 ],
                      ['SBI Gold Exchange Traded Scheme-Growth', '24.43' ],
                      ['Kotak Gold ETF-Growth', '25.50' ] ].map { |etf|
    create :'data_provider/scheme', :name => etf.first, :prev3_year_comp_percent => etf.last }
  }

  let(:large_cap_schemes) { [ create(:'data_provider/scheme', :bench_mark_index_name => 'NSE Index',
                                  :prev3_year_comp_percent => 22, :code => '14001200', :plan_code => '2066'),
                              create(:'data_provider/scheme', :bench_mark_index_name => 'BSE 100 Index',
                                  :prev3_year_comp_percent => 16, :code => '14001340', :plan_code => '2067') ] }

  let(:mid_cap_schemes) { [ create(:'data_provider/scheme', :bench_mark_index_name => 'CNX Midcap Index',
                              :prev3_year_comp_percent => 22, :code => '15002000', :plan_code => '2066'),
                              create(:'data_provider/scheme', :bench_mark_index_name => 'BSE Mid-Cap Index',
                                  :prev3_year_comp_percent => 16, :code => '15001200', :plan_code => '2067') ]
                   }

  context "#zero amount investments" do
    let(:risk_profiler) { ComprehensiveRiskProfiler.new(score_cache: 1) }

    subject do
      risk_profiler.save(validate: false)
      IdealInvestmentMix.new(risk_profiler)
    end

    its(:gold_investments) { should be_empty }
    its(:fixed_deposits)   { should_not be_empty }
    its(:large_caps)       { should be_empty }
    its(:mid_caps)         { should be_empty }

  end

  context "#with default risk profiler" do
    let(:risk_profiler) { ComprehensiveRiskProfiler.new(score_cache: 6) }

    subject do
      risk_profiler.save(validate: false)
      IdealInvestmentMix.new(risk_profiler)
    end

    its(:initial_investment) { should eq 30000 }
    its(:asset_allocation)   { should eq({ 'Fixed Deposits' => 40, 'Large Cap Stocks' => 20,
                                           'Mid Cap Stocks' => 10, 'Gold' => 30 }) }
    its(:gold_amount)        { should eq 9000 }
    its(:fd_amount)          { should eq 12000 }
    its(:large_cap_amount)   { should eq 6000 }
    its(:mid_cap_amount)     { should eq 3000 }

    it "should have gold etfs" do
      gold_etfs.each{ |scheme| scheme.save }
      subject.gold_investments.count.should eq 1
      subject.gold_investments.first.to_a.should eq [["name", gold_etfs.last.name], ["amount", 9000]]
    end

    it "should have top gold etfs" do
      create :'data_provider/scheme', :name => 'Goldman Sachs Gold Exchange Traded Scheme-Growth', :class_description => 'Special Fund', :prev3_year_comp_percent => 25.45
      create :'data_provider/scheme', :name => 'SBI Gold Exchange Traded Scheme-Growth', :class_description => 'Special Fund', :prev3_year_comp_percent => 25.34
      create :'data_provider/scheme', :name => 'Kotak Gold ETF-Growth', :class_description => 'Special Fund', :prev3_year_comp_percent => 25.50

      scheme = create :'data_provider/scheme'
      subject.top_gold_etfs(2).should_not include scheme
      subject.top_gold_etfs(2).map(&:name).should eq [ 'Kotak Gold ETF-Growth',
                                                    'Goldman Sachs Gold Exchange Traded Scheme-Growth' ]
    end

    it "should have fixed deposits" do
      subject.fixed_deposits.first.amount.should eq 6000
      subject.fixed_deposits.map(&:name).should include *banks.map(&:name)
    end

    let(:scheme) { create :'data_provider/scheme' }
    context "#Top Large Caps" do
      before(:each) { scheme.save }

      it "should be filtered from Schemes by bench mark index name" do
        cnx_scheme = create :'data_provider/scheme', :code => '14000000', :plan_code => '2066', :bench_mark_index_name => 'NSE CNX 100'
        bse_scheme = create :'data_provider/scheme', :code => '15000000', :plan_code => '2067', :bench_mark_index_name => 'BSE 100 Index'
        subject.top_large_caps(2).should_not include scheme
        subject.top_large_caps(2).should include( cnx_scheme, bse_scheme)
      end

      it "should be filtered by minimum investment" do
        cnx_scheme = create :'data_provider/scheme', :code => '14000000', :plan_code => '2066', :bench_mark_index_name => 'NSE CNX 100', :minimum_investment_amount => 5000
        bse_scheme = create :'data_provider/scheme', :code => '15000000', :plan_code => '2067', :bench_mark_index_name => 'BSE 100 Index', :minimum_investment_amount => 3500
        another_cnx_scheme = create :'data_provider/scheme', :bench_mark_index_name => 'NSE CNX 100', :minimum_investment_amount => 10000

        subject.top_large_caps(2).should_not include(scheme, another_cnx_scheme)
        subject.top_large_caps(2).should include(cnx_scheme, bse_scheme)
      end

      it "should be filtered by size" do
        cnx_scheme = create :'data_provider/scheme', :code => '14000000', :plan_code => '2066', :bench_mark_index_name => 'NSE CNX 100', :size => 500
        bse_scheme = create :'data_provider/scheme', :code => '15000000', :plan_code => '2067', :bench_mark_index_name => 'BSE 100 Index', :size => 50
        another_cnx_scheme = create :'data_provider/scheme', :bench_mark_index_name => 'NSE CNX 100', :size => 25

        subject.top_large_caps(2).should_not include(scheme, another_cnx_scheme)
        subject.top_large_caps(2).should include(cnx_scheme, bse_scheme)
      end

      it "should be filtered by entry load and exit load" do
        cnx_scheme = create :'data_provider/scheme', :code => '14000000', :plan_code => '2066', :bench_mark_index_name => 'NSE CNX 100', :entry_load => nil, :exit_load => 2
        bse_scheme = create :'data_provider/scheme', :code => '15000000', :plan_code => '2067', :bench_mark_index_name => 'BSE 100 Index', :entry_load => 1, :exit_load => 1
        another_cnx_scheme = create :'data_provider/scheme', :bench_mark_index_name => 'NSE CNX 100', :entry_load => 1, :exit_load => 1.25

        subject.top_large_caps(2).should_not include(scheme, another_cnx_scheme)
        subject.top_large_caps(2).should include(cnx_scheme, bse_scheme)
      end

      it "should include goldman sachs though the minimum investment criteria is not matched" do
        goldman_nifty = create :'data_provider/scheme', :security_code => "17024319.002066",
                                :prev3_year_comp_percent => 22, :code => '17024319', :plan_code => '2066', :prev3_year_comp_percent => 18
        cnx_scheme = create :'data_provider/scheme', :code => '14000000', :plan_code => '2066', :bench_mark_index_name => 'NSE CNX 100', :prev3_year_comp_percent => 16
        another_cnx_scheme = create :'data_provider/scheme', :code => '15000000', :plan_code => '2067', :bench_mark_index_name => 'NSE CNX 100', :prev3_year_comp_percent => 12

        subject.top_large_caps(2).should_not include(another_cnx_scheme)
        subject.top_large_caps(2).should include(cnx_scheme, goldman_nifty)
      end
    end

    it "should have large caps" do
      large_cap_schemes.each { |scheme| scheme.save }
      subject.large_caps.count.should eq 1
      subject.large_caps.first.amount.should eq 6000
      subject.large_caps.first.name.should eq large_cap_schemes.first.name
    end

    context "#Top Mid Caps" do
      before(:each) { scheme.save }
      it "should be filtered from schemes by bench mark index name" do
        cnx_scheme = create :'data_provider/scheme', :code => '14000000', :plan_code => '2066', :bench_mark_index_name => 'CNX Midcap Index'
        bse_scheme = create :'data_provider/scheme', :code => '15000000', :plan_code => '2067', :bench_mark_index_name => 'BSE Mid-Cap Index'
        subject.top_mid_caps(2).should_not include scheme
        subject.top_mid_caps(2).should include( cnx_scheme, bse_scheme)
      end

      it "should be filtered by minimum investment" do
        cnx_scheme = create :'data_provider/scheme', :code => '14000000', :plan_code => '2066', :bench_mark_index_name => 'CNX Midcap Index', :minimum_investment_amount => 5000
        bse_scheme = create :'data_provider/scheme', :code => '15000000', :plan_code => '2067', :bench_mark_index_name => 'BSE Mid-Cap Index', :minimum_investment_amount => 3500
        another_cnx_scheme = create :'data_provider/scheme', :code => '16000000', :plan_code => '2067', :bench_mark_index_name => 'CNX Midcap Index', :minimum_investment_amount => 10000

        subject.top_mid_caps(2).should_not include(scheme, another_cnx_scheme)
        subject.top_mid_caps(2).should include(cnx_scheme, bse_scheme)
      end

      it "should be filtered by size" do
        cnx_scheme = create :'data_provider/scheme', :code => '14000000', :plan_code => '2066', :bench_mark_index_name => 'CNX Midcap Index', :size => 500
        bse_scheme = create :'data_provider/scheme', :code => '15000000', :plan_code => '2067', :bench_mark_index_name => 'BSE Mid-Cap Index', :size => 50
        another_cnx_scheme = create :'data_provider/scheme', :bench_mark_index_name => 'CNX Midcap Index', :size => 25

        subject.top_mid_caps(2).should_not include(scheme, another_cnx_scheme)
        subject.top_mid_caps(2).should include(cnx_scheme, bse_scheme)
      end

      it "should be filtered by entry load and exit load" do
        cnx_scheme = create :'data_provider/scheme', :code => '14000000', :plan_code => '2066', :bench_mark_index_name => 'CNX Midcap Index', :entry_load => nil, :exit_load => 2
        bse_scheme = create :'data_provider/scheme', :code => '15000000', :plan_code => '2067', :bench_mark_index_name => 'BSE Mid-Cap Index', :entry_load => 1, :exit_load => 1
        another_cnx_scheme = create :'data_provider/scheme', :bench_mark_index_name => 'CNX Midcap Index', :entry_load => 1, :exit_load => 1.25

        subject.top_mid_caps(2).should_not include(scheme, another_cnx_scheme)
        subject.top_mid_caps(2).should include(cnx_scheme, bse_scheme)
      end

      it "should get top two schemes by prev3_year_comp_percent" do
        cnx_scheme = create :'data_provider/scheme', :code => '14000000', :plan_code => '2066', :bench_mark_index_name => 'CNX Midcap Index', :prev3_year_comp_percent => 16
        bse_scheme = create :'data_provider/scheme', :code => '15000000', :plan_code => '2067', :bench_mark_index_name => 'BSE Mid-Cap Index', :prev3_year_comp_percent => 14
        another_cnx_scheme = create :'data_provider/scheme', :bench_mark_index_name => 'CNX Midcap Index', :prev3_year_comp_percent => 10

        subject.top_mid_caps(2).should_not include(scheme, another_cnx_scheme)
        subject.top_mid_caps(2).should include(cnx_scheme, bse_scheme)
      end

      it "should scope the elss funds" do
        scheme.update_attributes(:class_code => 2119)
        another_scheme = create :'data_provider/scheme'
        subject.top_elss_funds.should include scheme
        subject.top_elss_funds.should_not include another_scheme
      end
    end

    it "should have mid caps" do
      mid_cap_schemes.each { |scheme| scheme.save }
      subject.mid_caps.count.should eq 1
      subject.mid_caps.first.amount.should eq 3000
      subject.mid_caps.first.name.should eq mid_cap_schemes.first.name
    end

    it "should have security mix" do
      gold_etfs.each{ |scheme| scheme.save }
      large_cap_schemes.each { |scheme| scheme.save }
      mid_cap_schemes.each { |scheme| scheme.save }
      subject.security_mix.count.should eq 5
      subject.security_mix.should include([gold_etfs.last.name, 9000], [banks.first.name, 6000],
        [banks.last.name, 6000], [ large_cap_schemes.first.name, 6000], [ mid_cap_schemes.first.name, 3000])
    end

    context "#Initial Investment" do
      it { should respond_to(:initial_investment=) }
      it "should allow initial investment to be set" do
        subject.initial_investment= 50000
        subject.initial_investment.should eq 50000
        subject.send(:fd_amount).should eq 20000
      end

      it "should always be greater than or equal to 30000" do
        subject.initial_investment= 20000
        subject.initial_investment.should eq 30000
      end
    end
  end

  context "#with custom risk profiler" do
    let(:comprehensive_risk_profiler) { create :comprehensive_risk_profiler,
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
      :time_horizon             => 4
    }

    subject { IdealInvestmentMix.new(comprehensive_risk_profiler) }

    its(:initial_investment) { should eq 130000 }
    its(:asset_allocation)   { should eq({ 'Fixed Deposits' => 30, 'Large Cap Stocks' => 20,
                                           'Mid Cap Stocks' => 20, 'Gold' => 30 }) }
    its(:gold_amount)        { should eq 39000 }
    its(:fd_amount)          { should eq 39000 }
    its(:large_cap_amount)   { should eq 26000 }
    its(:mid_cap_amount)     { should eq 26000 }

    it "should have gold etfs" do
      gold_etfs.each{ |scheme| scheme.save }
      subject.gold_investments.count.should eq 2
      subject.gold_investments.first.amount.should eq 19500
      subject.gold_investments.map(&:name).should eq [ gold_etfs.last.name, gold_etfs.first.name ]
    end

    it "should have fixed deposits" do
      subject.fixed_deposits.first.amount.should eq 19500
      subject.fixed_deposits.map(&:name).should include *banks.map(&:name)
    end

    it "should have large caps" do
      large_cap_schemes.each { |scheme| scheme.save }
      subject.large_caps.count.should eq 2
      subject.large_caps.first.amount.should eq 13000
      subject.large_caps.map(&:name).should eq large_cap_schemes.map(&:name)
    end

    it "should have mid caps" do
      mid_cap_schemes.each { |scheme| scheme.save }
      subject.mid_caps.count.should eq 2
      subject.mid_caps.first.amount.should eq 13000
      subject.mid_caps.map(&:name).should eq mid_cap_schemes.map(&:name)
    end
  end

end
