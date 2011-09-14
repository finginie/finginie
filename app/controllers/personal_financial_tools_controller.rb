class PersonalFinancialToolsController < ApplicationController
  def emi_calculators
    @emi_calculator = EmiCalculator.new(params[:emi_calculator])
  end
end
