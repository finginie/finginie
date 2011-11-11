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
    fill_in "life_insurance_calculator[existing_life_insurance]",                :with => 500000
    fill_in "life_insurance_calculator[existing_provident_fund]",                :with => 2000000
    fill_in "life_insurance_calculator[total_outstanding_liabilities]",          :with => 1500000
    fill_in "life_insurance_calculator[total_assets]",                           :with => 5000000
    fill_in "life_insurance_calculator[desired_value_of_bequeathed_estate]",     :with => 20000000
    fill_in "life_insurance_calculator[family_income]",                          :with => 900000

    2.times { click_link   "Add Dependent" }
    within "fieldset:nth-child(1)" do
      fill_in "years",    :with => 10
      fill_in "Expenses", :with => 800000
    end
    within "fieldset:nth-child(2)" do
      fill_in "years",    :with => 15
      fill_in "Expenses", :with => 300000
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

  it "Should calculate the correct final sip amount" do
    visit sip_calculator_path
    fill_in      "sip_calculator[initial_investment]",        :with => 1
    fill_in      "sip_calculator[monthly_amount]",            :with => 2000
    fill_in      "sip_calculator[no_months]",                 :with => 12
    fill_in      "sip_calculator[rate_of_return]",            :with => 10
    click_button "Calculate Final Amount Received"
    page.should have_content("25341.67")
  end

  it "Should calculate the correct monthly sip" do
    visit monthly_sip_calculator_path
    fill_in      "monthly_sip_calculator[financial_goal]", :with => 1000000
    fill_in      "monthly_sip_calculator[rate_of_return]", :with => 11
    fill_in      "monthly_sip_calculator[no_months]",      :with => 24
    click_button "Calculate Monthly Investment"
    page.should have_content("37101.08")
  end

  it "Should calculate the correct rate of return" do
    visit rate_of_return_calculator_path
    fill_in      "rate_of_return_calculator[initial_investment]", :with => 200000
    fill_in      "rate_of_return_calculator[received_amount]",    :with => 400000
    fill_in      "rate_of_return_calculator[no_years]",           :with => 5
    click_button "Find Rate of Return on the Investment"
    page.should have_content("14.87")
  end

  it "Should calculate the correct recurring deopsit maturity amount" do
    visit recurring_deposit_calculator_path
    fill_in      "recurring_deposit_calculator[amount_deposit]", :with => 20000
    fill_in      "recurring_deposit_calculator[rate_of_return]", :with => 9.25
    fill_in      "recurring_deposit_calculator[no_months]",      :with => 12
    select       "Quarterly"
    click_button "Calculate Maturity Amount Received"
    page.should have_content("252274.69")
  end

  it "Should calculate the correct required monthly saving" do
    visit retirement_corpus_calculator_path
    fill_in      "retirement_corpus_calculator[current_age]",       :with => 42
    fill_in      "retirement_corpus_calculator[retirement_age]",    :with => 60
    fill_in      "retirement_corpus_calculator[monthly_expence]",   :with => 15000
    fill_in      "retirement_corpus_calculator[inflation]",         :with => 6
    fill_in      "retirement_corpus_calculator[expected_return]",   :with => 9
    click_button "Calculate Monthly Savings"
    page.should have_content("14948.55")
  end
end
