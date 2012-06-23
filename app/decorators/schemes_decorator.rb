class SchemesDecorator
  include DatatablesDecorator

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: DataProvider::Scheme.active.count,
      iTotalDisplayRecords: schemes && schemes.count,
      aaData: data || []
    }
  end

private

  def data
    schemes && schemes.map do |scheme|
      [
        link_to(scheme.name, Rails.application.routes.url_helpers.mutual_fund_path(scheme)),
        h(scheme.class_description),
        h(scheme.minimum_investment_amount)
      ]
    end
  end

  def schemes
    @schemes ||= fetch_schemes
  end

  def fetch_schemes
    if params[:sSearch].present?
      schemes = DataProvider::Scheme.active.order([[ sort_column.to_sym, sort_direction.to_sym]])
      schemes = schemes.page(page).per(per_page)
      schemes = schemes.csearch(params[:sSearch])
    end
    schemes
  end

  def sort_column
    columns = %w[name class_description minimum_investment_amount]
    columns[params[:iSortCol_0].to_i]
  end

end
