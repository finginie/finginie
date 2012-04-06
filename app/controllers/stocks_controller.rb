class StocksController < InheritedResources::Base
  actions :index, :show

  def resource
    @search = Company.new
    @stock = Company.find_by_company_code(params[:id])
    @chart_url =  "http://www.cs4w.in/Forska/TechnicalChart.aspx?Code=#{@stock.nse_code}&width=800" + "&height=600"
    @stock = CompanyDecorator.decorate(@stock)
  end

  def collection
    @search = Company.new
    if params[:company]
      @search_records = Company.stocks.csearch(params[:company].values.join(" "))
      @companies = @search_records.page(params[:page]).per(10)
      @search_records.all.map {|stock| {:value => stock.company_name, :id => stock.company_code}}
    end
  end

end
