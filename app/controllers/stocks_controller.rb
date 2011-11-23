class StocksController < InheritedResources::Base
  actions :index, :show

  def collection
    @search = end_of_association_chain.search(params[:search])
    @stocks = @search.page params[:page]
  end
end
