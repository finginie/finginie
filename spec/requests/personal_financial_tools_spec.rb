require 'spec_helper'

describe 'PersonalFinancialTools' do
  it "Should Calculate the correct Emi" do
    visit emi_calculators_path
    fill_in      "emi_calculator[cost]",          :with => 400000
    fill_in      "emi_calculator[down_payment]",  :with => 100000
    fill_in      "emi_calculator[rate]",          :with => 12.5
    fill_in      "emi_calculator[term]",          :with => 5
    click_button "Calculate EMI"
    page.should have_content("6749.38")
  end

  describe 'income_tax_calculator' do
    it "should calculate payable_tax" do

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
      click_button 'Calculate Income Tax Payable'

      page.should have_content 249466

    end
  end

  it "Should calculate the correct additional life insurance required", :js => true do
    visit life_insurance_calculators_path
    fill_in      "life_insurance_calculator[existing_life_insurance]",                :with => 500000
    fill_in      "life_insurance_calculator[existing_provident_fund]",                :with => 2000000
    fill_in      "life_insurance_calculator[total_outstanding_liabilities]",          :with => 1500000
    fill_in      "life_insurance_calculator[total_assets]",                           :with => 5000000
    fill_in      "life_insurance_calculator[desired_value_of_bequeathed_estate]",     :with => 20000000
    fill_in      "life_insurance_calculator[family_income]",                          :with => 900000
    click_link   "Add Dependent"
    click_link   "Add Dependent"

    fieldsets = page.all("fieldset")
    within fieldsets.first do
        fill_in      "years",                                                         :with => 10
        fill_in      "Expenses",                                                      :with => 800000
    end
    within fieldsets.second do
        fill_in      "years",                                                         :with => 15
        fill_in      "Expenses",                                                      :with => 300000
    end

    click_button "Calculate Additional Insurance Needed"
    page.should have_content("14352006")
  end

  it "Should calculate the correct fixed deposit maturity amount" do
    visit fixed_deposit_calculators_path
    fill_in      "fixed_deposit_calculator[amount_invested]", :with => 10000
    fill_in      "fixed_deposit_calculator[rate_of_return]",  :with => 8.75
    fill_in      "fixed_deposit_calculator[no_months]",       :with => 12
    select       "Quarterly"
    click_button "Find Maturity Amount Received"
    page.should have_content("10904.13")
  end
end
