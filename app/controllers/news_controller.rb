class NewsController < InheritedResources::Base
  actions :show

  def resource
    @news = News.where( company_code: params[:stock_id], headlines: params[:id]).first
  end
end
