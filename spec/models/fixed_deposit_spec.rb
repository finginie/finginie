require 'spec_helper'

describe FixedDeposit do
  it { should validate_presence_of :period }
  it { should validate_presence_of :rate_of_interest }

  let(:fixed_deposit) { create :fixed_deposit, :period => 5, :rate_of_interest => 8.89 }
  describe "with transaction" do
    let(:transaction) { create :transaction, :net_position => create(:net_position, :security => fixed_deposit), :price => 10000, :date => Date.civil(2007, 1, 31) }
    subject { transaction }

    its(:maturity_value) { should eq 15309 }

    its(:current_value) {
      Timecop.freeze (Date.civil(2011, 11, 8)) do
        should eq 15015
      end
    }

    its(:current_value) {
      Timecop.freeze (Date.civil(2014, 11, 8)) do
        should eq 15309
      end
    }
  end

end
