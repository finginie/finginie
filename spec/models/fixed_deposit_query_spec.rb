require 'spec_helper'

describe FixedDepositQuery do
  let(:fixed_deposit_query) { FixedDepositQuery.new(:amount => 100, :year => 1, :days => 2, :month => 3) }
  it { should validate_numericality_of :month  }
  it { should validate_numericality_of :year   }
  it { should validate_numericality_of :days   }
  it { should validate_numericality_of :amount }
  it { should_not allow_value(-1).for(:month)  }
  it { should_not allow_value(-1).for(:year)   }
  it { should_not allow_value(-1).for(:days)   }
  it { should_not allow_value(-1).for(:amount) }
  it { should     allow_value("").for(:month) }
  it { should     allow_value("").for(:days)  }
  it { should     allow_value("").for(:year)  }
  it { should     allow_value(0).for(:month)  }
  it { should     allow_value(30).for(:days)  }
  it { should     allow_value(0).for(:days)   }
  it { should     allow_value(0).for(:year)   }
end
