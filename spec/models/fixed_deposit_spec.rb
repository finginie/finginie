require 'spec_helper'

describe FixedDeposit do
  it { should validate_presence_of :period }
  it { should validate_presence_of :rate_of_interest }
  it { should validate_numericality_of :period }
  it { should validate_numericality_of :rate_of_interest }
  it { should_not allow_value(-1).for(:period) }
  it { should_not allow_value(-1).for(:rate_of_interest) }

end
