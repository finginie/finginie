class MutualFundsController < InheritedResources::Base
  actions :index, :show
  custom_actions :resource => [ :scheme_returns, :top_holdings, :detailed_holdings, :asset_allocation, :sectoral_allocation ]

  def collection
    @search = DataProvider::Scheme.new
    if params[:term]
      @search_records = DataProvider::Scheme.active.csearch(params[:term], :allow_empty_search => true).order_by([[:name, :asc]]).limit(10)
      @search_records.all.map {|scheme| {:value => scheme.name, :id => scheme.slug }}
    else
      @categories = DataProvider::NetAssetValueCategory.all( sort: [[:scheme_class_description, :asc]])
    end
  end

  def resource
    @search = DataProvider::Scheme.new
    @scheme = DataProvider::Scheme.find_by_slug(params[:id])
    @scheme = SchemeDecorator.decorate(@scheme)
  end

  def index
    index! do |format|
      format.html
      format.json { render json: (params[:term] ? collection : SchemesDecorator.new(view_context) ) }
    end
  end

end
