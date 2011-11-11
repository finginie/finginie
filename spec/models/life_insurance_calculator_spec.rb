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

  its(:extra_insurance_required) { should eq 14352006 }
end
