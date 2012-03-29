class StocksController < InheritedResources::Base
  actions :index, :show

  def resource
    @search = end_of_association_chain.search
    @chart_url =  "http://www.cs4w.in/Forska/TechnicalChart.aspx?Code=" + super.symbol + "&width=800" + "&height=600"
    @stock = StockDecorator.decorate(super)
  end

  def collection
    @search = end_of_association_chain.search(params[:search])
    if params[:search] && !params[:search][:sector_contains]
      @search.all.map{ |stock| {:value => stock.name, :id => stock.id}}
    else
      @stocks = @search.page params[:page]
    end
  end
end
