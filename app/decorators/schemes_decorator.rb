class SchemesDecorator

  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

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

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[scheme_name industry_name minimum_investment_amount]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

end
