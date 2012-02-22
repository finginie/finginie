class NewsController < InheritedResources::Base
  belongs_to :stock
  actions :show

  def resource
    @news = News.where( company_code: parent.company_code, headlines: params[:id]).first
  end
end
