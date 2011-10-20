require 'spec_helper'

describe 'PersonalFinancialTools' do
  describe 'income_tax_calculator' do
    it "should calculate payable_tax", :js => true do

      visit income_tax_calculator_path
      fill_in "income_tax_calculator[age]", :with => 34
      choose "income_tax_calculator_sex_female"
      choose "income_tax_calculator_metro_true"
      fill_in "income_tax_calculator[basic_salary]", :with => 120000
      fill_in "income_tax_calculator[house_rent_allowance]", :with => 20000
      fill_in "income_tax_calculator[rent]", :with => 15000
      fill_in "income_tax_calculator[medical_allowance]", :with => 2000
      fill_in "income_tax_calculator[conveyence_allowance]", :with => 14000
      fill_in "income_tax_calculator[provident_fund]", :with => 120000
      fill_in "income_tax_calculator[life_insurance_premium]", :with => 120000
      fill_in "income_tax_calculator[equity_linked_tax_saving]", :with => 31200
      fill_in "income_tax_calculator[pension_fund]", :with => 0
      fill_in "income_tax_calculator[unit_linked_insurance_plan]", :with => 0
      fill_in "income_tax_calculator[national_savings_certificate]", :with => 0
      fill_in "income_tax_calculator[fixed_deposits_in_scheduled_banks]", :with => 18000
      fill_in "income_tax_calculator[principal_repayment_of_housing_loans]", :with => 60000
      fill_in "income_tax_calculator[stamp_duty_and_registration_charges]", :with => 0
      fill_in "income_tax_calculator[education_expenses]", :with => 0
      fill_in "income_tax_calculator[infrastructure_bonds]", :with => 21000
      fill_in "income_tax_calculator[interest_on_a_housing_loan]", :with => 250000
      fill_in "income_tax_calculator[health_insurance_premium]", :with => 10000
      fill_in "income_tax_calculator[interest_repayment_on_education_loan]", :with => 60000
      click_button "Calculate Income Tax Payable"

      page.should have_content 249466

    end
  end
end
