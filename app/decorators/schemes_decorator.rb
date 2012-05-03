class SchemesDecorator
  include DatatablesDecorator

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Scheme.count,
      iTotalDisplayRecords: schemes.count,
      aaData: data
    }
  end

private

  def data
    schemes.map do |scheme|
      [
        link_to(scheme.scheme_name, Rails.application.routes.url_helpers.scheme_summary_mutual_fund_path(scheme.scheme_name)),
        h(scheme.scheme_class_description),
        h(scheme.minimum_investment_amount)
      ]
    end
  end

  def schemes
    @schemes ||= fetch_schemes
  end

  def fetch_schemes
    if params[:sSearch].present?
      schemes = Scheme.all.order([[ sort_column.to_sym, sort_direction.to_sym]])
      schemes = schemes.page(page).per(per_page)
      schemes = schemes.csearch(params[:sSearch])
    end
    schemes
  end

  def sort_column
    columns = %w[scheme_name industry_name minimum_investment_amount]
    columns[params[:iSortCol_0].to_i]
  end

end
