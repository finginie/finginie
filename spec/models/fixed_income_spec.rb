require 'spec_helper'

describe FixedIncome do
  it { should validate_presence_of :period }
  it { should validate_presence_of :rate_of_interest }

  let(:fixed_income) { create :fixed_income, :period => 5, :rate_of_interest => 8.89 }
end
