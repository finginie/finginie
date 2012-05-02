class StocksController < InheritedResources::Base
  actions :index, :show

  def resource
    @search = Company.new
    @company = Company.find_by_company_code(params[:id])
    @chart_url =  "http://www.cs4w.in/Forska/TechnicalChart.aspx?Code=#{@company.nse_code}&width=800" + "&height=600" if @company && @company.nse_code
    CompanyDecorator.decorate(@company)
  end

  def collection
    @search = Company.new
    if params[:company]
      @search_records = Company.stocks.csearch(params[:company].values.join(" "))
      @search_records.all.map {|stock| {:value => stock.company_name, :id => stock.company_code}}
    end
  end

  def index
    index! do |format|
      format.html
      if params[:company]
        format.json { render json: collection }
      else
        format.json { render json: CompaniesDecorator.new(view_context) }
      end
    end
  end

end
