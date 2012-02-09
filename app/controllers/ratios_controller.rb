class RatiosController < InheritedResources::Base
  def show
    @stock  = Stock.find(params[:stock_id])
    if @stock.company && @stock.company.major_sector == 2
      @ratio = BankingRatio.all( conditions: { company_code: @stock.company_code }, sort: [[ :year_ending, :desc ]] ).first
      @ratio = BankingRatioDecorator.decorate(@ratio)
    end
    if @stock.company && @stock.company.major_sector != 2
      @ratio = Ratio.all( conditions: { company_code: @stock.company_code }, sort: [[ :year_ending, :desc ]] ).first
      @ratio = RatioDecorator.decorate(@ratio)
    end
  end
end
