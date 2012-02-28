class StocksController < InheritedResources::Base
  actions :index, :show

  def resource
    @chart_url =  "http://www.cs4w.in/Forska/TechnicalChart.aspx?Code=" + super.symbol + "&width=800" + "&height=600"
    @stock = StockDecorator.decorate(super)
  end

  def collection
    @search = end_of_association_chain.search(params[:search])
    @stocks = @search.page params[:page]
  end
end
