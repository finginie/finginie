class PersonalFinancialToolsController < ApplicationController
  def emi_calculators
    @emi_calculator = EmiCalculator.new(params[:emi_calculator])
  end

  def fixed_deposit_calculators
    @fixed_deposit_calculator = FixedDepositCalculator.new(params[:fixed_deposit_calculator])
  end

  def income_tax_calculator
    @income_tax_calculator = IncomeTaxCalculator.new(params[:income_tax_calculator])
  end

  def life_insurance_calculators
    @life_insurance_calculator = LifeInsuranceCalculator.new(params[:life_insurance_calculator])
  end
end
