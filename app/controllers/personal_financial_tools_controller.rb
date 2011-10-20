class PersonalFinancialToolsController < ApplicationController
  def emi_calculators
    @emi_calculator = EmiCalculator.new(params[:emi_calculator])
  end

  def income_tax_calculators
    @income_tax_calculator = IncomeTaxCalculator.new(params[:income_tax_calculator])
  end
end
