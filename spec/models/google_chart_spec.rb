require 'spec_helper'

describe GoogleChart do

  context "#pie chart" do
    let(:gchart){ GoogleChart.new(:data => { 'gold' => '1', 'mutual_fund' => '3', 'fixed_deposit' => IndianCurrency.new(60000)}.to_a, :title => 'Suggested Asset Allocation', :type => 'Pie')}

    subject { gchart }

    its(:elements) { should eq [['',''] , ['gold', 1], ['mutual_fund', 3], ['fixed_deposit', 60000]] }
    its (:data) { should eq [ ['gold', 1], ['mutual_fund', 3], ['fixed_deposit', 60000]] }
    its(:header) { should eq ['', ''] }

    it "should have header if header is given" do
      gchart.header= [ 'Asset Class', 'Percentage']
      gchart.elements.should eq [['Asset Class','Percentage'] , ['gold', 1], ['mutual_fund', 3], ['fixed_deposit', 60000]]
    end
  end

  context "#column chart" do
    let(:gchart){ GoogleChart.new(:data => [['gold', '1', 3], ['mutual_fund', '3', 4], ['fixed_deposit', IndianCurrency.new(60000), 5]], :title => 'Suggested Asset Allocation', :type => 'Column')}

    subject { gchart }

    its(:elements) { should eq [['','', ''] , ['gold', 1, 3], ['mutual_fund', 3, 4], ['fixed_deposit', 60000, 5]] }
    its (:data) { should eq [ ['gold', 1, 3], ['mutual_fund', 3, 4], ['fixed_deposit', 60000, 5]] }
    its(:header) { should eq ['', '', ''] }

    it "should have header if header is given" do
      gchart.header= [ 'Asset Class', 'Amount', 'Percentage']
      gchart.elements.should eq [['Asset Class', 'Amount', 'Percentage'] , ['gold', 1, 3], ['mutual_fund', 3, 4], ['fixed_deposit', 60000, 5]]
    end
  end

  context "#invalid data" do
    let(:gchart){ GoogleChart.new(:data => [['gold', '1'], ['mutual_fund', '3', BigDecimal.new('23')], ['fixed_deposit' , IndianCurrency.new(60000), BigDecimal.new('23')]], :title => 'Suggested Asset Allocation', :type => 'Pie')}

    it "should have header if header is given" do
      lambda { gchart.elements }.should raise_error
    end

    it "should have header if header is given" do
      gchart.header= [ 'Asset Class', 'Percentage']
      lambda { gchart.data }.should raise_error
    end
  end
end
