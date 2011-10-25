class StocksController < InheritedResources::Base
  def collection
    @search = end_of_association_chain.search(params[:search])
    @stocks = @search.all
  end
end
