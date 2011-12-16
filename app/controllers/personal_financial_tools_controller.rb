class PersonalFinancialToolsController < ApplicationController
  def emi_calculators
    @emi_calculator = EmiCalculator.new(params[:emi_calculator])
    flash[:success] ="The equated monthly installment is Rs. #{@emi_calculator.calculate_emi}" if params[ :commit]
  end

  def fixed_deposit_calculators
    @fixed_deposit_calculator = FixedDepositCalculator.new(params[:fixed_deposit_calculator])
    flash[:success] ="The amount you received at maturity is Rs. #{@fixed_deposit_calculator.maturity_amount}" if params[ :commit]
  end

  def income_tax_calculator
    @income_tax_calculator = IncomeTaxCalculator.new(params[:income_tax_calculator])
    flash[:success] = "The net tax you are liable to pay is Rs. #{@income_tax_calculator.tax_payable}" if params[:commit]
  end

  def life_insurance_calculators
    @life_insurance_calculator = LifeInsuranceCalculator.new(params[:life_insurance_calculator])
    flash[:success] ="According to the informartion you entered, the extra insurance you need is Rs. #{@life_insurance_calculator.extra_insurance_required}" if params[:commit]
  end

  def monthly_sip_calculator
    @monthly_sip_calculator = MonthlySipCalculator.new(params[:monthly_sip_calculator])
    flash[:success] ="The monthly you need to invest to reach your goal is Rs. #{@monthly_sip_calculator.monthly_sip}" if params[ :commit]
  end

  def rate_of_return_calculator
    @rate_of_return_calculator = RateOfReturnCalculator.new(params[:rate_of_return_calculator])
    flash[:success] ="The rate of return earned on your investment is Rs. #{@rate_of_return_calculator.calculate_rate_of_return}" if params[ :commit]
  end

  def recurring_deposit_calculator
    @recurring_deposit_calculator = RecurringDepositCalculator.new(params[:recurring_deposit_calculator])
    flash[:success] ="The amount you will receive at maturity is Rs. #{@recurring_deposit_calculator.maturity_amount}" if params[ :commit]
  end

  def retirement_corpus_calculator
    @retirement_corpus_calculator = RetirementCorpusCalculator.new(params[:retirement_corpus_calculator])
    flash[:success] ="The corpus you need to meet your expenses after retirement is Rs. #{@retirement_corpus_calculator.monthly_return}" if params[ :commit]
  end

  def sip_calculator
    @sip_calculator = SipCalculator.new(params[:sip_calculator])
    flash[:success] ="The monthly amount you invest will accumlate to Rs. #{@sip_calculator.calculate_sip}" if params[ :commit]
  end
end
