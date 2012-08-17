class IdealInvestmentsCell < Cell::Rails
  helper ChartHelper

  def public(args)
    @ideal_investment_mix = args[:ideal_investment_mix]
    @chart_data = @ideal_investment_mix.public_security_mix
    @value_type = 'percentage'
    render :view => 'chart_ideal_investments_and_elss_info'
  end

  def private(args)
    @ideal_investment_mix = args[:ideal_investment_mix]
    @chart_data = @ideal_investment_mix.security_mix
    @value_type = 'amount'
    render :view => 'chart_ideal_investments_and_elss_info'
  end

end
