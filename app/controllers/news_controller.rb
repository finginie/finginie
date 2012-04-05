class NewsController < InheritedResources::Base
  actions :show

  def resource
    @company = Company.find_by_company_code(params[:stock_id])
    @news = News.where( company_code: @company.company_code, headlines: params[:id]).first
  end
end
