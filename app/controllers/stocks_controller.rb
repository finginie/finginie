class StocksController < InheritedResources::Base
  actions :index, :show

  custom_actions :collection => :screener

  def resource
    @search = Company.new
    @company = Company.find_by_company_code(params[:id])
    @chart_url =  "http://www.cs4w.in/Forska/TechnicalChart.aspx?Code=#{@company.nse_code}&width=800" + "&height=600" if @company && @company.nse_code
    CompanyDecorator.decorate(@company)
  end

  def collection
    @search = Company.new
    if params[:company]
      @search_records = Company.stocks.csearch(params[:company].values.join(" ")).order_by([[:company_name, :asc]])
      @search_records.all.map {|stock| {:value => stock.company_name, :id => stock.company_code}}
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
