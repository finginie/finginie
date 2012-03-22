require 'spec_helper'

describe FixedDeposit do
  let(:fixed_deposit) { create :fixed_deposit }
  subject { fixed_deposit }

  it { should validate_presence_of :period }
  it { should validate_presence_of :rate_of_interest }
  it { should validate_numericality_of :period }
  it { should validate_numericality_of :rate_of_interest }
  it { should_not allow_value(-1).for(:period) }
  it { should allow_value(1).for(:rate_of_interest) }
  it { should allow_value(12.75).for(:rate_of_interest) }
  it { should_not allow_value(12751).for(:rate_of_interest) }
  it { should_not allow_value(-1).for(:rate_of_interest) }
  it { should have_many :fixed_deposit_transactions }

end
