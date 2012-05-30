class RatiosController < InheritedResources::Base
  defaults :singleton => true
  actions :show

  def resource
    @search = Company.new
    @company = Company.find_by_name(params[:stock_id] )
    if @company
      if @company.major_sector == 2
        @ratios = BankingRatio.all( conditions: { company_code: @company.code }, sort: [[ :year_ending, :desc ]], limit: 5 )
        @ratios = BankingRatioDecorator.decorate(@ratios)
      else
        @ratios = Ratio.all( conditions: { company_code: @company.code }, sort: [[ :year_ending, :desc ]], limit: 5 )
        @ratios = RatioDecorator.decorate(@ratios)
      end
    end
  end
end
