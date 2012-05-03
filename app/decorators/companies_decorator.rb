class CompaniesDecorator
  include DatatablesDecorator

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Company.stocks.count,
      iTotalDisplayRecords: stocks.count,
      aaData: data
    }
  end

private

  def data
    stocks.map do |stock|
      [
        link_to(stock.name, Rails.application.routes.url_helpers.stock_path(stock.company_code)),
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
    stocks = Company.stocks.order([[ sort_column.to_sym, sort_direction.to_sym]])
    stocks = stocks.page(page).per(per_page)
    if params[:sSearch].present?
      stocks = stocks.csearch(params[:sSearch])
    end
    stocks
  end

  def sort_column
    columns = %w[name sector current_price pe]
    columns[params[:iSortCol_0].to_i]
  end

end
