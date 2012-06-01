class MutualFundsCell < Cell::Rails
  helper ApplicationHelper
  helper NumberHelper

  def top_funds
    schemes = Scheme.all( sort: [[ :percentage_change, :desc ]], limit: 10)
    @top_performers = SchemeDecorator.decorate(schemes)
    render
  end

  def biggest_funds
    schemes = Scheme.all( sort: [[ :size, :desc ]], limit: 10)
    @biggest_schemes = SchemeDecorator.decorate(schemes)
    render
  end

end
