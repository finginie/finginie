class RatiosController < InheritedResources::Base
  defaults :singleton => true
  actions :show

  def resource
    @search = Company.new
    @company = Company.find_by_company_code(params[:stock_id])
    if @company
      if @company.major_sector == 2
        @ratio = BankingRatio.all( conditions: { company_code: @company.company_code }, sort: [[ :year_ending, :desc ]] ).first
        @ratio = BankingRatioDecorator.decorate(@ratio)
      else
        @ratio = Ratio.all( conditions: { company_code: @company.company_code }, sort: [[ :year_ending, :desc ]] ).first
        @ratio = RatioDecorator.decorate(@ratio)
      end
    end
  end
end
