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
      scheme = SchemeDecorator.decorate(scheme)
      { :name                      => link_to(scheme.name, Rails.application.routes.url_helpers.mutual_fund_path(scheme)),
        :class_description         => h(scheme.class_description),
        :minimum_investment_amount => h(scheme.minimum_investment_amount),
        :nav_amount                => h(scheme.nav_amount),
        :day_change                => h(scheme.day_change),
        :percentage_change         => h(scheme.percentage_change),
        :size                      => h(scheme.size),
        :prev1_month_percent       => h(scheme.prev1_month_percent),
        :prev_year_percent         => h(scheme.prev_year_percent),
        :prev3_year_percent        => h(scheme.prev3_year_percent)
      }
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
    elsif DataProvider::Scheme.respond_to?(params[:scope])
      schemes = DataProvider::Scheme.send(params[:scope], params[:limit])
    end
    schemes
  end

  def sort_column
    columns = %w[name class_description minimum_investment_amount]
    columns[params[:iSortCol_0].to_i]
  end

end
