class PersonalFinancialToolsController < ApplicationController
  def emi_calculators
    @emi_calculator = EmiCalculator.new(params[:emi_calculator])
    flash.now[:result] ="The equated monthly installment is Rs. #{@emi_calculator.calculate_emi}" if params[:commit] && @emi_calculator.valid?
  end

  def fixed_deposit_calculators
    @fixed_deposit_calculator = FixedDepositCalculator.new(params[:fixed_deposit_calculator])
    flash.now[:result] ="The amount you will receive at maturity is Rs. #{@fixed_deposit_calculator.maturity_amount}" if params[:commit] && @fixed_deposit_calculator.valid?
  end

  def income_tax_calculator
    @income_tax_calculator = IncomeTaxCalculator.new(params[:income_tax_calculator])
    flash.now[:result] = "The net tax you are liable to pay is Rs. #{@income_tax_calculator.tax_payable}" if params[:commit] && @income_tax_calculator.valid?
  end

  def life_insurance_calculators
    @life_insurance_calculator = LifeInsuranceCalculator.new(params[:life_insurance_calculator])
    flash.now[:result] ="According to the informartion you entered, the extra insurance you need is Rs. #{@life_insurance_calculator.extra_insurance_required}" if params[:commit] && @life_insurance_calculator.valid?
  end

  def monthly_sip_calculator
    @monthly_sip_calculator = MonthlySipCalculator.new(params[:monthly_sip_calculator])
    flash.now[:result] ="The monthly amount you need to invest to reach your goal is Rs. #{@monthly_sip_calculator.monthly_sip}" if params[ :commit] && @monthly_sip_calculator.valid?
  end

  def rate_of_return_calculator
    @rate_of_return_calculator = RateOfReturnCalculator.new(params[:rate_of_return_calculator])
    flash.now[:result] ="The rate of return earned on your investment is Rs. #{@rate_of_return_calculator.calculate_rate_of_return}" if params[ :commit] && @rate_of_return_calculator.valid?
  end

  def recurring_deposit_calculator
    @recurring_deposit_calculator = RecurringDepositCalculator.new(params[:recurring_deposit_calculator])
    flash.now[:result] ="The amount you will receive at maturity is Rs. #{@recurring_deposit_calculator.maturity_amount}" if params[ :commit] && @recurring_deposit_calculator.valid?
  end

  def retirement_corpus_calculator
    @retirement_corpus_calculator = RetirementCorpusCalculator.new(params[:retirement_corpus_calculator])
    flash.now[:result] ="You need to save Rs. #{@retirement_corpus_calculator.monthly_savings} per month to meet your retirement expenses" if params[ :commit] && @retirement_corpus_calculator.valid?
  end

  def sip_calculator
    @sip_calculator = SipCalculator.new(params[:sip_calculator])
    flash.now[:result] ="The monthly amount you invest will accumlate to Rs. #{@sip_calculator.calculate_sip}" if params[ :commit] && @sip_calculator.valid?
  end
end
