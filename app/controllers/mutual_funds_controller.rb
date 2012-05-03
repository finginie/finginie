class MutualFundsController < InheritedResources::Base
  actions :index
  custom_actions :resource => [ :scheme_summary, :scheme_returns, :top_holdings, :detailed_holdings, :asset_allocation, :sectoral_allocation ]

  def collection
    @search = Scheme.new
    if params[:term]
      @search_records = Scheme.search(params[:term], :allow_empty_search => true)
      @search_records.all.map(&:scheme_name)
    else
      @categories = NetAssetValueCategory.all( sort: [[:scheme_class_description, :asc]])
    end
  end

  def resource
    @search = Scheme.new
    @scheme = Scheme.where( scheme_name: params[:id] ).first
    @scheme = SchemeDecorator.decorate(@scheme)
  end

  def index
    index! do |format|
      format.html
      format.json { render json: (params[:term] ? collection : SchemesDecorator.new(view_context) ) }
    end
  end

end
