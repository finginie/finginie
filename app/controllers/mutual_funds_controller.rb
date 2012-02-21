class MutualFundsController < InheritedResources::Base
  actions :index, :scheme_summary, :scheme_returns, :top_holdings, :detailed_holdings, :asset_allocation, :sectoral_allocation

  def index
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

  def scheme_summary
    redirect_to 'mutual_funds_path' if !params[:id]
    @scheme = SchemeMaster.where( scheme_name: params[:id] ).first
    @scheme = SchemeMasterDecorator.decorate(@scheme)
  end

  def scheme_returns
    redirect_to 'mutual_funds_path' if !params[:id] 
    @scheme = SchemeMaster.where( scheme_name: params[:id] ).first
    @scheme = SchemeMasterDecorator.decorate(@scheme)
  end

  def top_holdings
    redirect_to 'mutual_funds_path' if !params[:id]
    @scheme = SchemeMaster.where( scheme_name: params[:id] ).first
    @scheme = SchemeMasterDecorator.decorate(@scheme)
  end

  def detailed_holdings
    redirect_to 'mutual_funds_path' if !params[:id]
    @scheme = SchemeMaster.where( scheme_name: params[:id] ).first
    @scheme = SchemeMasterDecorator.decorate(@scheme)
  end

  def asset_allocation
    redirect_to 'mutual_funds_path' if !params[:id]
    @scheme = SchemeMaster.where( scheme_name: params[:id] ).first
    @scheme = SchemeMasterDecorator.decorate(@scheme)
  end

  def sectoral_allocation
    redirect_to 'mutual_funds_path' if !params[:id]
    @scheme = SchemeMaster.where( scheme_name: params[:id] ).first
    @scheme = SchemeMasterDecorator.decorate(@scheme)
  end

end
