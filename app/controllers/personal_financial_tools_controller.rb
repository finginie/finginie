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

  def monthly_sip_calculator
    @monthly_sip_calculator = MonthlySipCalculator.new(params[:monthly_sip_calculator])
  end

  def rate_of_return_calculator
    @rate_of_return_calculator = RateOfReturnCalculator.new(params[:rate_of_return_calculator])
  end

  def sip_calculator
    @sip_calculator = SipCalculator.new(params[:sip_calculator])
  end
end
