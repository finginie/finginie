class CompaniesDecorator
  include DatatablesDecorator

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: DataProvider::Company.stocks.count,
      iTotalDisplayRecords: stocks && stocks.count,
      aaData: data || []
    }
  end

private

  def data
    stocks && stocks.map do |stock|
      [
        link_to(stock.name, Rails.application.routes.url_helpers.stock_path(stock)),
        h(stock.sector),
        h(stock.current_price),
        h(stock.nse.percent_change || stock.bse.percent_change),
        h(stock.pe)
      ]
    end
  end

  def stocks
    @stocks ||= fetch_stocks
  end

  def fetch_stocks
    if params[:sSearch].present?
      stocks = DataProvider::Company.stocks.order([[ sort_column.to_sym, sort_direction.to_sym]])
      stocks = stocks.order([[ :name, :asc ]]) unless sort_column
      stocks = stocks.page(page).per(per_page)
      stocks = stocks.csearch(params[:sSearch])
    end
    stocks
  end

  def sort_column
    columns = %w[ name industry_name current_price percent_change pe]
    columns[params[:iSortCol_0].to_i]
  end

end
