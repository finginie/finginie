class MutualFundsController < InheritedResources::Base
  actions :index
  custom_actions :resource => [ :scheme_summary, :scheme_returns, :top_holdings, :detailed_holdings, :asset_allocation, :sectoral_allocation ]

  def collection
    @search = SchemeMaster.new
    if params[:scheme_master]
      @search_records = SchemeMaster.search(params[:scheme_master][:scheme_name], :allow_empty_search => true)
      @scheme_masters = @search_records.page(params[:page]).per(10)
    else
      @categories = NavCategoryDetail.all( sort: [[:scheme_class_description, :asc]])
    end
  end

  def resource
    @scheme = SchemeMaster.where( scheme_name: params[:id] ).first
    @scheme = SchemeMasterDecorator.decorate(@scheme)
  end

end
