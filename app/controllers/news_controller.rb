class NewsController < InheritedResources::Base
  actions :show

  def resource
    @news = News.where( company_code: @company.company_code, headlines: params[:id]).first
  end
end
