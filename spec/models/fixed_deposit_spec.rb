require 'spec_helper'

describe FixedDeposit do
  it { should validate_presence_of :period }
  it { should validate_presence_of :rate_of_interest }

end
