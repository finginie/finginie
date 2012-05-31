class StocksController < InheritedResources::Base
  actions :index, :show

  custom_actions :collection => :screener

  def resource
    @search = Company.new
    @company = Company.find_by_name(params[:id])
    CompanyDecorator.decorate(@company)
  end

  def collection
    @search = Company.new
    if params[:company]
      @search_records = Company.stocks.csearch(params[:company].values.join(" ")).order_by([[:name, :asc]])
      @search_records.all.map {|stock| {:value => stock.name, :id => stock.code}}
    elsif params[:screener]
      @search_records = Company.screener_search(params[:screener])
      @companies = @search_records.page(params[:page]).per(10)
    end
  end

  def index
    index! do |format|
      format.html
      format.json { render json: (params[:company] ? collection : CompaniesDecorator.new(view_context)) }
    end
  end

  def screener
  end
end
