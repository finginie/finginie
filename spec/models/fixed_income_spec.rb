require 'spec_helper'

describe FixedIncome do
  let(:fixed_income) { create :fixed_income, :period => 5, :rate_of_interest => 8.89 }
  describe "with transaction" do
    let(:transaction) { create :transaction, :net_position => create(:net_position, :security => fixed_income), :price => 10000, :date => Date.civil(2007, 1, 31) }
    subject { transaction }

    its(:current_value) {
      Timecop.freeze (Date.civil(2011, 11, 8)) do
        should eq 15015
      end
    }
  end
end
