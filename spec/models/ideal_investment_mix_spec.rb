require 'spec_helper'

describe IdealInvestmentMix, :mongoid do

  context "#with default risk profiler" do
    let(:risk_profiler) { ComprehensiveRiskProfiler.new(score_cache: 6) }

    subject do
      risk_profiler.save(validate: false)
      IdealInvestmentMix.new(risk_profiler)
    end

    its(:initial_investment) { should eq 30000 }
    its(:asset_allocation)   { should eq({ 'Fixed Deposits' => 40,   'Large Cap Stocks' => 20,  'Mid Cap Stocks' => 10, 'Gold' => 30 }) }
    its(:gold_amount)        { should eq 9000 }

    it "should have top gold etfs" do
      create :'data_provider/scheme', :name => 'Goldman Sachs Gold Exchange Traded Scheme-Growth', :class_description => 'Special Fund', :prev3_year_comp_percent => 25.45
      create :'data_provider/scheme', :name => 'SBI Gold Exchange Traded Scheme-Growth', :class_description => 'Special Fund', :prev3_year_comp_percent => 25.34
      create :'data_provider/scheme', :name => 'Kotak Gold ETF-Growth', :class_description => 'Special Fund', :prev3_year_comp_percent => 25.50

      scheme = create :'data_provider/scheme'
      subject.top_gold_etfs.should_not include scheme
      subject.top_gold_etfs.map(&:name).should eq [ 'Kotak Gold ETF-Growth',
                                                    'Goldman Sachs Gold Exchange Traded Scheme-Growth' ]
    end

    it "should have gold etfs" do

      create :'data_provider/scheme', :name => 'Goldman Sachs Gold Exchange Traded Scheme-Growth',
                                      :class_description => 'Special Fund', :prev3_year_comp_percent => 25.45
      create :'data_provider/scheme', :name => 'Kotak Gold ETF-Growth',
                                      :class_description => 'Special Fund', :prev3_year_comp_percent => 25.50

      subject.gold_investments.count.should eq 1
      subject.gold_investments.first.to_a.should eq [["name", "Kotak Gold ETF-Growth"], ["amount", 9000]]
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
    its(:asset_allocation)   { should eq({ 'Fixed Deposits' => 30,   'Large Cap Stocks' => 20,  'Mid Cap Stocks' => 20, 'Gold' => 30 }) }
    its(:gold_amount)        { should eq 39000 }

    it "should have gold etfs" do

      create :'data_provider/scheme', :name => 'Goldman Sachs Gold Exchange Traded Scheme-Growth',
                                      :class_description => 'Special Fund', :prev3_year_comp_percent => 25.45
      create :'data_provider/scheme', :name => 'Kotak Gold ETF-Growth',
                                      :class_description => 'Special Fund', :prev3_year_comp_percent => 25.50

      subject.gold_investments.count.should eq 2
      subject.gold_investments.first.amount.should eq 19500
      subject.gold_investments.map(&:name).should eq [ 'Kotak Gold ETF-Growth', 'Goldman Sachs Gold Exchange Traded Scheme-Growth']

    end
  end

end
