class NewsController < InheritedResources::Base
  actions :show

  def resource
    @company = Company.find_by_code(params[:stock_id])
    @news = News.find(params[:id])
  end
end
