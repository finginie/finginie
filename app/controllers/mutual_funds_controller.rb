class MutualFundsController < InheritedResources::Base
  actions :index, :scheme_summary, :scheme_returns, :top_holdings, :detailed_holdings, :asset_allocation, :sectoral_allocation

  def index
    @mutual_funds = SchemeMaster.all
    index!
  end

  def resource
    @scheme = SchemeMaster.where( scheme_name: params[:id] ).first
    @scheme = SchemeMasterDecorator.decorate(@scheme)
  end

  def scheme_summary
    @scheme = SchemeMaster.where( scheme_name: params[:id] ).first
    @scheme = SchemeMasterDecorator.decorate(@scheme)
  end

  def scheme_returns
    @scheme = SchemeMaster.where( scheme_name: params[:id] ).first
    @scheme = SchemeMasterDecorator.decorate(@scheme)
  end

  def top_holdings

  end

  def detailed_holdings

  end

  def asset_allocation

  end

  def sectoral_allocation

  end
end
