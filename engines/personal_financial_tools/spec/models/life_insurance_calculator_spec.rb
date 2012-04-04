require 'spec_helper'

describe LifeInsuranceCalculator do
  subject { LifeInsuranceCalculator.new(
        :existing_life_insurance            => "500000",
        :existing_provident_fund            => "2000000",
        :total_outstanding_liabilities      => "1500000",
        :total_assets                       => "5000000",
        :desired_value_of_bequeathed_estate => "20000000",
        :family_income                      => "900000",
        :dependents_attributes              => {
          "0"                               => { expense: "800000", years: "10" },
          "1"                               => { expense: "300000", years: "15" }
        }
  )}

  it { should validate_presence_of :desired_value_of_bequeathed_estate }
  it { should validate_presence_of :family_income }

  it { should validate_numericality_of :existing_life_insurance            }
  it { should validate_numericality_of :existing_provident_fund            }
  it { should validate_numericality_of :total_outstanding_liabilities      }
  it { should validate_numericality_of :total_assets                       }
  it { should validate_numericality_of :desired_value_of_bequeathed_estate }
  it { should validate_numericality_of :family_income                      }

  it { should_not allow_value(-1).for :existing_life_insurance            }
  it { should_not allow_value(-1).for :existing_provident_fund            }
  it { should_not allow_value(-1).for :total_outstanding_liabilities      }
  it { should_not allow_value(-1).for :total_assets                       }
  it { should_not allow_value(0).for :desired_value_of_bequeathed_estate  }
  it { should_not allow_value(0).for :family_income                       }

  its(:extra_insurance_required) { should eq 14352006 }
end
