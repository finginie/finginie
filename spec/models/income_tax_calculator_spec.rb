require 'spec_helper'

describe IncomeTaxCalculator do
  it "should calculate the right income tax" do

    IncomeTaxCalculator.new(
      :age                                          => 34,
      :sex                                          => 'Female',
      :metro                                        => 'metro',
      :basic_salary                                 => 120000,
      :house_rent_allowance                         => 20000,
      :rent                                         => 15000,
      :medical_allowance                            => 2000,
      :conveyence_allowance                         => 14000,
      :provident_fund                               => 120000,
      :life_insurance_premium                       => 120000,
      :equity_linked_tax_saving                     => 31200,
      :pension_fund                                 => 0,
      :unit_linked_insurance_plan                   => 0,
      :national_savings_certificate                 => 0,
      :fixed_deposits_in_scheduled_banks            => 18000,
      :principal_repayment_of_housing_loans         => 60000,
      :stamp_duty_and_registration_charges          => 0,
      :education_expenses                           => 0,
      :infrastructure_bonds                         => 21000,
      :interest_on_a_housing_loan                   => 250000,
      :health_insurance_premium                     => 10000,
      :interest_repayment_on_education_loan         => 60000
    ).tax_payable.should eq 249466

    IncomeTaxCalculator.new(
      :age                                          => 45,
      :sex                                          => 'Male',
      :metro                                        => 'metro',
      :basic_salary                                 => 75000,
      :house_rent_allowance                         => 10000,
      :rent                                         => 9000,
      :medical_allowance                            => 8000,
      :conveyence_allowance                         => 3000,
      :life_insurance_premium                       => 30000,
      :equity_linked_tax_saving                     => 6000,
      :pension_fund                                 => 0,
      :provident_fund                               => 84000,
      :unit_linked_insurance_plan                   => 0,
      :national_savings_certificate                 => 0,
      :fixed_deposits_in_scheduled_banks            => 120000,
      :principal_repayment_of_housing_loans         => 24000,
      :stamp_duty_and_registration_charges          => 0,
      :education_expenses                           => 0,
      :infrastructure_bonds                         => 25000,
      :interest_on_a_housing_loan                   => 120000,
      :health_insurance_premium                     => 15000,
      :interest_repayment_on_education_loan         => 0
    ).tax_payable.should eq 83842

    IncomeTaxCalculator.new(
      :age                                          => 65,
      :sex                                          => 'Female',
      :metro                                        => 'NonMetro',
      :basic_salary                                 => 20000,
      :house_rent_allowance                         => 5000,
      :rent                                         => 5000,
      :medical_allowance                            => 17000,
      :conveyence_allowance                         => 2000,
      :life_insurance_premium                       => 36000,
      :equity_linked_tax_saving                     => 8400,
      :pension_fund                                 => 0,
      :provident_fund                               => 24000,
      :unit_linked_insurance_plan                   => 0,
      :national_savings_certificate                 => 0,
      :fixed_deposits_in_scheduled_banks            => 144000,
      :principal_repayment_of_housing_loans         => 12000,
      :stamp_duty_and_registration_charges          => 0,
      :education_expenses                           => 0,
      :infrastructure_bonds                         => 12000,
      :interest_on_a_housing_loan                   => 180000,
      :health_insurance_premium                     => 17000,
      :interest_repayment_on_education_loan         => 30000
    ).tax_payable.should eq 0

    IncomeTaxCalculator.new(
      :age                                          => 84,
      :sex                                          => 'Male',
      :metro                                        => 'metro',
      :basic_salary                                 => 45000,
      :house_rent_allowance                         => 8000,
      :rent                                         => 8000,
      :medical_allowance                            => 12000,
      :conveyence_allowance                         => 1500,
      :provident_fund                               => 26000,
      :life_insurance_premium                       => 48000,
      :equity_linked_tax_saving                     => 3600,
      :pension_fund                                 => 0,
      :unit_linked_insurance_plan                   => 0,
      :national_savings_certificate                 => 0,
      :fixed_deposits_in_scheduled_banks            => 60000,
      :principal_repayment_of_housing_loans         => 100000,
      :stamp_duty_and_registration_charges          => 0,
      :education_expenses                           => 1200,
      :infrastructure_bonds                         => 18000,
      :interest_on_a_housing_loan                   => 100000,
      :health_insurance_premium                     => 25000,
      :interest_repayment_on_education_loan         => 12000
    ).tax_payable.should eq 0
  end
end
