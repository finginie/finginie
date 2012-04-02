class RatiosController < InheritedResources::Base
  belongs_to :stock, :singleton => true
  actions :show

  def resource
    @search = Stock.search
    if parent.company
      if parent.company.major_sector == 2
        @ratio = BankingRatio.all( conditions: { company_code: parent.company_code }, sort: [[ :year_ending, :desc ]] ).first
        @ratio = BankingRatioDecorator.decorate(@ratio)
      else
        @ratio = Ratio.all( conditions: { company_code: parent.company_code }, sort: [[ :year_ending, :desc ]] ).first
        @ratio = RatioDecorator.decorate(@ratio)
      end
    end
  end
end
