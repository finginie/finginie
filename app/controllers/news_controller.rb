class NewsController < InheritedResources::Base
  actions :show

  def resource
    @company = DataProvider::Company.find_by_slug(params[:stock_id])
    @news = DataProvider::News.find(params[:id])
  end
end
