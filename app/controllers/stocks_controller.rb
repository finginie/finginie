class StocksController < InheritedResources::Base
  actions :index, :show

  custom_actions :collection => :screener

  def resource
    @search = DataProvider::Company.new
    @company = DataProvider::Company.find_by_slug(params[:id])
    CompanyDecorator.decorate(@company)
  end

  def collection
    @search = DataProvider::Company.new
    if params[:term]
      @search_records = DataProvider::Company.stocks.csearch(params[:term]).order_by([[:name, :asc]]).limit(10)
      @search_records.all.map {|stock| {:value => stock.name, :id => stock.slug}}
    elsif params[:screener]
      @search_records = DataProvider::Company.screener_search(params[:screener])
      @companies = @search_records.page(params[:page]).per(10)
    end
  end

  def index
    index! do |format|
      format.html
      format.json { render json: (params[:term] ? collection : CompaniesDecorator.new(view_context)) }
    end
  end

  def screener
  end
end
