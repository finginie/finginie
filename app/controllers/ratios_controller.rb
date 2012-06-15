class RatiosController < InheritedResources::Base
  defaults :singleton => true
  actions :show

  def resource
    @search =  DataProvider::Company.new
    @company =  DataProvider::Company.find_by_slug(params[:stock_id] )
    if @company
      if @company.major_sector == 2
        @ratios = DataProvider::BankingRatio.all( conditions: { company_code: @company.code }, sort: [[ :year_ending, :desc ]], limit: 5 )
        @ratios = BankingRatioDecorator.decorate(@ratios)
      else
        @ratios = DataProvider::Ratio.all( conditions: { company_code: @company.code }, sort: [[ :year_ending, :desc ]], limit: 5 )
        @ratios = RatioDecorator.decorate(@ratios)
      end
    end
  end
end
